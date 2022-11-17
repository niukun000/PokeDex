//
//  ViewController.swift
//  PokeDex
//
//  Created by Kun Niu on 11/14/22.
//

import UIKit

class ViewController: UIViewController {

    lazy var pokemonTableView : UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.contentMode = .scaleAspectFit
        tableView.backgroundColor = .systemGray5
        tableView.dataSource = self
        tableView.delegate = self
        tableView.prefetchDataSource = self
        tableView.register(PokemonlTableViewCell.self, forCellReuseIdentifier: "PokemonCell")
        
        return tableView
    }()
    
    var network : NetworkManager
    var currentPage : PageResult?
    var pokemons : [NameLink] = []
    let url = URL(string: "https://pokeapi.co/api/v2/pokemon")
    let margin = 8
    
    init(network: NetworkManager = NetworkManager()) {
        self.network = network
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
        self.requestNextPage()
        
        // Do any additional setup after loading the view.
    }
    
    private func requestNextPage(){
        let pageUrl : URL?
        if let currentPage = self.currentPage{
            pageUrl = currentPage.next
        }
        else{
            pageUrl = self.url
        }
        guard let pageUrl = pageUrl else {
            return
        }
        self.network.fetchPageResult(with: pageUrl){
            resultPage in
//            print(resultPage?.results[3].url as Any)
            guard let resultPage = resultPage else{
                print("failed to fetch pageresult \(pageUrl)")
                return
            }
            self.currentPage = resultPage
            self.pokemons.append(contentsOf: resultPage.results)
//
            DispatchQueue.main.async {
                self.pokemonTableView.reloadData()
            }
        }
    }

    private func createUI(){
        self.title = "Pokemon Table"
        self.view.backgroundColor = .white
        self.view.addSubview(pokemonTableView)
        
        self.pokemonTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        self.pokemonTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        self.pokemonTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.pokemonTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        
    }

}



extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return min(self.pokemons.count, 151)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("start creating cells")
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as? PokemonlTableViewCell else{
            print("failed when creating cell for indexPath \(indexPath)")
            return UITableViewCell()
        }
        print("namelabel adding")
        cell.nameLabel.text = self.pokemons[indexPath.row].name
        guard let tempUrl = self.pokemons[indexPath.row].url else{
            return UITableViewCell()
        }
        
        let name = self.pokemons[indexPath.row].name
        
        
        if let data : Cach = ImageCache.shared.get(name: name){
            cell.nameLabel.text = data.name
            cell.pokemonImageView.image = UIImage(data: data.data)
            cell.typeLabel.text = "\(data.types)"
        }
        
        self.network.fetchPokemon(with: tempUrl){
            result in
            guard let result = result else{
                print("failed to fetch pokemon")
                return
            }
            var types = "|"
            result.types.forEach(){
                type in
                types += " \(type.type.name) |"
            }
            guard let pictureUrl = result.sprites.frontDefault else{
                return
            }
            self.network.fetchRawData(url: pictureUrl){
                picture in
                guard let picture = picture else{
                    return
                }
                
                ImageCache.shared.set(name: name, data: Cach(name:name, types:types, data:picture))
                
                DispatchQueue.main.async {
                    
                    cell.typeLabel.text = types
                    cell.pokemonImageView.image = UIImage(data: picture)
                    
                    
                }
                
            }
        }

        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("start creating VC")
        let VC = PokemonDetailViewController()
        guard let cell : PokemonlTableViewCell = tableView.cellForRow(at: indexPath) as? PokemonlTableViewCell else{
            return
        }
        guard let name = cell.nameLabel.text else{
            return
        }
        guard name == self.pokemons[indexPath.row].name else {
            return
        }
        guard let pokemonUrl = URL(string: "https://pokeapi.co/api/v2/pokemon/\(name)") else{
            return
        }
        self.network.fetchPokemon(with: pokemonUrl){
            result in
            DispatchQueue.main.async {
                guard let result = result else{
                    return
                }
                VC.nameLabel.text = result.name
                VC.title = result.name
                let abilities = result.abilities.compactMap { Abilities in
                    Abilities.ability.name
                }
                VC.abilitiesLabel.text = "Abilities: \(abilities)"
                let moves = result.moves.compactMap { Moves in
                    Moves.move.name
                }
                VC.moveLabel.text = "Moves: \(moves)"
                if let imgUrl = result.sprites.versions.generationV?.blackWhite.animated.frontShiny
                {
                    print(imgUrl)
                    self.network.fetchRawData(url: imgUrl){
                        data in
                        guard let data = data else{
                            return
                        }
                        DispatchQueue.main.async {
                            VC.pokemonImage.image = UIImage(data: data)
                        }
                    }
                }else{
                    VC.pokemonImage.image = cell.pokemonImageView.image
                }
            }
        }
        self.navigationController?.pushViewController(VC, animated: true)
//        return
    }
}

extension ViewController : UITableViewDataSourcePrefetching{
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let lastIndexPath = IndexPath(row: self.pokemons.count - 1, section: 0)
        print(lastIndexPath)
        guard indexPaths.contains(lastIndexPath) else { return }
        self.requestNextPage()
    }
}


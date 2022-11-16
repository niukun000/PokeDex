//
//  PokemonDetailViewController.swift
//  PokeDex
//
//  Created by Kun Niu on 11/15/22.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    lazy var nameLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.backgroundColor = .systemBlue
        
        return label
    }()
    lazy var pokemonImage : UIImageView = {
        let image = UIImageView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
//        image.sizeToFit()
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setUpUI()
    }
    private func setUpUI(){
        self.title = "Pokemon"
        self.view.backgroundColor = .white
        self.view.addSubview(pokemonImage)
        self.view.addSubview(nameLabel)
        
        self.pokemonImage.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        self.pokemonImage.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        self.pokemonImage.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        
        self.pokemonImage.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor).isActive = true
//        self.pokemonImage.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        self.pokemonImage.sizeToFit()
        self.nameLabel.textAlignment = .center
        self.nameLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        self.nameLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 100).isActive = true
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

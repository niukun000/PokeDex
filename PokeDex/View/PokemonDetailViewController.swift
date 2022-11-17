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
//        label.font.withSize(600)
//        label.backgroundColor = .systemBlue
//        label.font = .systemFont(ofSize: 60)
        label.textColor = .red
        return label
    }()
    lazy var pokemonImage : UIImageView = {
        let image = UIImageView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
//        image.sizeToFit()
        return image
    }()
    lazy var abilitiesLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font.withSize(30)
        label.numberOfLines = 0
        label.backgroundColor = .systemBlue
        label.text = "Abilities"
        return label
    }()
    
    lazy var moveLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font.withSize(30)
        label.numberOfLines = 0
        label.backgroundColor = .systemGray
        label.text = "Moves"
        return label
    }()
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setUpUI()
    }
    private func setUpUI(){
        self.title = "Pokemon"
//        self.title.textColor = .red
        self.view.backgroundColor = .white
        self.view.addSubview(pokemonImage)
        self.view.addSubview(nameLabel)
        self.view.addSubview(abilitiesLabel)
        self.view.addSubview(moveLabel)
        
        self.pokemonImage.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        self.pokemonImage.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        self.pokemonImage.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        
        self.pokemonImage.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor).isActive = true
//        self.pokemonImage.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
//        self.pokemonImage.sizeToFit()
        self.nameLabel.textAlignment = .center
        self.nameLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        self.nameLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 100).isActive = true
        
        self.abilitiesLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        self.abilitiesLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        self.abilitiesLabel.topAnchor.constraint(equalTo: self.pokemonImage.bottomAnchor, constant: 20).isActive = true
        
        self.moveLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        self.moveLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        self.moveLabel.topAnchor.constraint(equalTo: self.abilitiesLabel.bottomAnchor, constant: 20).isActive = true
//        self.abilitiesLabel.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
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

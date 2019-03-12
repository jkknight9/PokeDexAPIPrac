//
//  PokemonViewController.swift
//  PokeDexAPIPrac
//
//  Created by Jack Knight on 3/12/19.
//  Copyright © 2019 Jack Knight. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController, UISearchBarDelegate, UITextFieldDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {return}
        
        PokemonController.shared.fetchPokemon(for: searchTerm) { (pokemon) in
            guard let pokemon = pokemon else {return}
            
            PokemonController.shared.fetchImageFor(pokemon: pokemon, completion: { (image) in
                DispatchQueue.main.async {
                    self.nameLabel.text = pokemon.name.capitalized
                    self.idLabel.text = "\(pokemon.id)"
                    self.abilitiesLabel.text = pokemon.abilityNames
                    self.pokemonImageView.image = image
                }
            })
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

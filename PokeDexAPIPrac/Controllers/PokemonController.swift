//
//  PokemonController.swift
//  PokeDexAPIPrac
//
//  Created by Jack Knight on 3/12/19.
//  Copyright © 2019 Jack Knight. All rights reserved.
//

import UIKit

class PokemonController {
    
    //Shared Instance
    
    static let shared = PokemonController()
    
    // Base URL
    static let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")
    
    //Fetch pokemon by search term
    
    func fetchPokemon(for searchTerm: String, completion: @escaping (Pokemon?) -> Void) {
        
        guard let searchURL = PokemonController.baseURL?.appendingPathComponent(searchTerm.lowercased()) else { completion(nil); return
            
        }
        
        // Datatask
        
        let dataTask = URLSession.shared.dataTask(with: searchURL) { (data, _, error) in
            if let error = error {
                print("🔥There was an error with dataTask : \(error.localizedDescription)🔥")
                completion(nil)
                return
            }
            guard let data = data else {completion(nil); return}
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(Pokemon.self, from: data)
                completion(decodedData)
                
            } catch let error {
                
                print("Error decdoing data from api: \(error.localizedDescription)")
                completion(nil)
                return
            }
        }
        dataTask.resume()
    }
    
    func fetchImageFor(pokemon: Pokemon, completion: @escaping (UIImage?) -> Void) {
        
        guard let imageURLAsString = pokemon.sprite.frontShiny else {completion(nil); return}
        
        guard let imageURL = URL(string: imageURLAsString) else {completion(nil)
        print("Error converting image string to URL")
        return
    }
    
        let dataTask = URLSession.shared.dataTask(with: imageURL) { (data, _, error) in
            if let error = error {
                print("Error with image data task: \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let data = data else { completion(nil); return}
            
            let image = UIImage(data: data)
            completion(image)
        }
        dataTask.resume()
    }
}

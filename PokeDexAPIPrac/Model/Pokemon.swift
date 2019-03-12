//
//  Pokemon.swift
//  PokeDexAPIPrac
//
//  Created by Jack Knight on 3/11/19.
//  Copyright © 2019 Jack Knight. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case abilities
        case sprite = "sprites"
    }
    
    let name: String
    let id: Int
    let abilities: [AbilityDictionary]
    let sprite: Sprite
    
    var abilityNames: String {
        let abilityArray = abilities.compactMap( { $0.ability.name })
        
        var returnString: String = ""
        
        for ability in abilityArray {
            if ability == abilityArray.first {
                returnString = "Abilities: \(ability.uppercased())"
            } else {
                returnString = "\(returnString) & \(ability.uppercased())"
            }
            
        }
        
        return returnString
        
    }
    
    struct AbilityDictionary: Codable {
        let ability: Ability
    }
    
    struct Ability: Codable {
        let name: String
    }
    
    struct Sprite: Codable {
        
        enum CodingKeys: String, CodingKey {
            case frontShiny = "front_shiny"
        }
        
        let frontShiny: String?
    }

}

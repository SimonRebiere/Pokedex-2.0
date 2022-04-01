//
//  PokemonListResponse.swift
//  Pokedex
//
//  Created by simon rebiere on 01/04/2022.
//

import Foundation

struct PokemonListResponse: Decodable {
    var next: String?
    var pokemonList: [Pokemon]

    struct Pokemon: Decodable {
        var name: String
        var url: String
    }
    
    enum CodingKeys: String, CodingKey {
        case next           = "next"
        case pokemonList    = "results"
    }
}

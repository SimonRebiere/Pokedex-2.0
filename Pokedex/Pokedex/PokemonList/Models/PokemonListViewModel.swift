//
//  PokemonListViewModel.swift
//  Pokedex
//
//  Created by simon rebiere on 03/04/2022.
//

import Foundation

struct PokemonListViewModel {
    struct PokemonRow {
        var imageURL: URL?
        var name: String
        var number: String
    }
    
    let rows: [PokemonRow]
}

//
//  PokemonListDataModel.swift
//  Pokedex
//
//  Created by simon rebiere on 03/04/2022.
//

import Foundation

class PokemonListDataModel {

    var nextURL: URL?
    var pokemonList: [Pokemon]
    
    struct Pokemon {
        var name: String
        var url: URL?
    }
    
    init(response: PokemonListResponse) {
        self.nextURL = URL(string: response.next ?? "")
        self.pokemonList = response.pokemonList.map( { Pokemon(name: $0.name, url: URL(string: $0.url)) } )
    }
    
    func update(with response: PokemonListResponse) {
        nextURL = URL(string: response.next ?? "")
        let newPokemons = response.pokemonList.map( { Pokemon(name: $0.name, url: URL(string: $0.url)) })
        pokemonList.append(contentsOf: newPokemons)
    }
}

//
//  PokemonListDataModel.swift
//  Pokedex
//
//  Created by simon rebiere on 03/04/2022.
//

import Foundation

//Chose to use a class here for the mutability of the model, the list can go up to 1000 elements
//So I want to avoid fully recreating it every time, since it's already done with the ViewModel
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

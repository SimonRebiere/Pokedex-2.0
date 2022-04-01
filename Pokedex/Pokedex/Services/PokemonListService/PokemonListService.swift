//
//  PokemonListService.swift
//  Pokedex
//
//  Created by simon rebiere on 01/04/2022.
//

import Foundation


protocol PokemonListServiceMethods {
    func getPokemonList(additionalParams: [String: Any]?, completion: @escaping (Result<PokemonListResponse, NetworkingError>) -> Void)
}

//warning: chercher si c'est plus opti de faire ses service en tant que class ou struct
//semble difficelement testable
struct PokemonListService: PokemonListServiceMethods {
    func getPokemonList(additionalParams: [String: Any]?, completion: @escaping (Result<PokemonListResponse, NetworkingError>) -> Void) {
        let networker = Networker<PokemonListEndpoint>()
        networker.fetchDecodable(endpoint: PokemonListEndpoint(additionnalParams: additionalParams), type: PokemonListResponse.self, completion: completion)
    }
}

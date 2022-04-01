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

//warning: A class might be better need to be checked
struct PokemonListService: PokemonListServiceMethods {
    
    let networker: NetworkingMethods
    
    init(networker: NetworkingMethods = Networker()) {
        self.networker = networker
    }
    
    func getPokemonList(additionalParams: [String: Any]?, completion: @escaping (Result<PokemonListResponse, NetworkingError>) -> Void) {
        networker.fetchDecodable(endpoint: PokemonListEndpoint(additionnalParams: additionalParams), type: PokemonListResponse.self, decoder: JSONDecoder(), completion: completion)
    }
}

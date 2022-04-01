//
//  PokemonListService.swift
//  Pokedex
//
//  Created by simon rebiere on 01/04/2022.
//

import Foundation


protocol PokemonListServiceMethods {
    func getPokemonList(completion: @escaping (PokemonListResponse) -> Void)
}

//warning: chercher si c'est plus opti de faire ses service en tant que class ou struct
struct PokemonListService: PokemonListServiceMethods {

    func getPokemonList(completion: @escaping (PokemonListResponse) -> Void) {
        let networker = Networker<PokemonListEndpoint>()
        networker.fetchDecodable(endpoint: PokemonListEndpoint(), type: PokemonListResponse.self, completion: { result in
            switch result {
            case .success(let response):
                completion(response)
            case .failure(let error):
                print(error.message)
            }
        })
    }
}

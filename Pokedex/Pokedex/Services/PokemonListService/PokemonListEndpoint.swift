//
//  PokemonListEndpoint.swift
//  Pokedex
//
//  Created by simon rebiere on 01/04/2022.
//

import Foundation

struct PokemonListEndpoint: EndpointType {

    var path: String { "pokemon" }
    var method: HTTPMethods { .get }
    
    var additionnalParams: [String: Any]?
    
    init(additionnalParams: [String: Any]? = nil) {
        self.additionnalParams = additionnalParams
    }
}

//
//  EndpointType.swift
//  Pokedex
//
//  Created by simon rebiere on 01/04/2022.
//

import Foundation

protocol EndpointType {
    var baseUrl: String { get }
    var path: String { get }
    var method: HTTPMethods { get }
    var additionnalParams: [String: Any]? { get set}
}

extension EndpointType {
    var baseUrl: String { return "https://pokeapi.co/api/v2/" }
}

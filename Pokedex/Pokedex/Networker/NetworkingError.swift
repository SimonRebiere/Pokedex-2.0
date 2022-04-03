//
//  NetworkingError.swift
//  Pokedex
//
//  Created by simon rebiere on 01/04/2022.
//

import Foundation

//Errors returned to services in case of failure
struct NetworkingError: Error {
    let errorType: NetworkingErrorType
    let message: String
}

enum NetworkingErrorType {
    case emptyData
    case decodingFailed
    case networkError(code: Int)
    
    var description: String {
        switch self {
        case .emptyData: return "The service recovered empty data where it should not."
        case .decodingFailed: return "Failed to decode data sent."
        case .networkError(let code): return "Networking Error: status code: \(code)"
        }
    }
}

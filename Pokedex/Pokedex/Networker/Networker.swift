//
//  Networker.swift
//  Pokedex
//
//  Created by simon rebiere on 24/03/2022.
//

import Foundation

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

//makes the request
protocol NetworkingMethods {
    //This function takes a generic endpoint to handle all request in the same way,
    //Endpoint contains all necessary informations for the URL to be constructed
    func fetchDecodable<DecodableObject: Decodable>(endpoint: EndpointType, type: DecodableObject.Type, decoder: JSONDecoder, completion: @escaping (Result<DecodableObject, NetworkingError>) -> Void)
}

class Networker: NetworkingMethods {
    func fetchDecodable<DecodableObject: Decodable>(endpoint: EndpointType,
                                                    type: DecodableObject.Type,
                                                    decoder: JSONDecoder,
                                                    completion: @escaping (Result<DecodableObject, NetworkingError>) -> Void) {
        var dataTask: URLSessionDataTask?
        dataTask?.cancel()
    
        guard let url = composeURL(endpoint: endpoint) else { return }
        let urlSession: URLSession = URLSession(configuration: .default)
        
        dataTask = urlSession.dataTask(with: url) { data, response, error in
            if error != nil, let response = response as? HTTPURLResponse {
                completion(.failure(NetworkingError(errorType: .networkError(code: response.statusCode),
                                                    message: response.description)))
            }
            
            if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                do {
                    let response = try decoder.decode(DecodableObject.self, from: data)
                    completion(.success(response))
                } catch let error {
                    completion(.failure(NetworkingError(errorType: .decodingFailed, message: error.localizedDescription)))
                }
            } else {
                completion(.failure(NetworkingError(errorType: .emptyData, message: "Data was empty")))
            }
        }
        dataTask?.resume()
    }
    
    //In order to create the url needed for the request, it is passed to this function, which will extract informations
    //from the endpoint. The viability of this url will be verified in the caller.
    private func composeURL(endpoint: EndpointType) -> URL? {
        var urlComponents = URLComponents(string: endpoint.baseUrl + endpoint.path)
        urlComponents?.queryItems = endpoint.queryParams

        return urlComponents?.url
    }
}

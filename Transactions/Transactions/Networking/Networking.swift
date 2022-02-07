//
//  Networking.swift
//  Transactions
//
//  Created by George Davies on 07/02/2022.
//

import Foundation

final class Networking {
    
    func fetch<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let response = response as? HTTPURLResponse,
            200...299 ~= response.statusCode {
                
                if let data = data {
                    do {
                        let decodedData = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(decodedData))
                    } catch {
                        completion(.failure(error))
                    }
                } else {
                    completion(.failure(NetworkingError.invalidData))
                }
                
            } else {
                completion(.failure(NetworkingError.generic))
            }
        }.resume()
    }
    
}

extension Networking {
    enum NetworkingError: Error {
        case generic
        case invalidData
    }
}

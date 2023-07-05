//
//  NetworkManager.swift
//  StoreAPI
//
//  Created by Froy on 6/30/23.
//

import Foundation
import Combine

extension String: Error {}

class NetworkManager {

    let productsUrl = "https://fakestoreapi.com/products"

    func getProducts() -> AnyPublisher<[Products], Error> {

        guard let url = URL(string: productsUrl) else {
            return Fail(error: "error URL").eraseToAnyPublisher()
        }

        return URLSession
            .shared
            .dataTaskPublisher(for: url)
//            .map { data, response in
//                return data
//            }
            .map { $0.data }
            .decode(type: [Products].self, decoder: JSONDecoder())
//            .mapError({ error in
//                return error.localizedDescription
//            })
            .mapError { error in error.localizedDescription }
            .eraseToAnyPublisher()
    }
    
}


//
//  ProductsViewModel.swift
//  StoreAPI
//
//  Created by Consultant on 6/30/23.
//

import Foundation
import Combine


class ProductsViewModel: ObservableObject {
    @Published private(set) var products = [Products]()
    private let networkManager = NetworkManager()
    private var subscribers = Set<AnyCancellable>()

    func loadProducts() {
        networkManager
            .getProducts()
            .sink { completion in
                switch completion {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { products in
                OperationQueue.main.addOperation { [weak self] in
                    self?.products = products
                }
            }
            .store(in: &subscribers)
    }
}

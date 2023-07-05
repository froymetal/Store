//
//  ProductosView.swift
//  StoreAPI
//
//  Created by Froy on 6/30/23.
//

import SwiftUI

struct ProductosView: View {
    @StateObject var productsviewModel = ProductsViewModel()
    var body: some View {
        NavigationView {
            Form {
                ForEach(productsviewModel.products, id: \.id) { product in
                    VStack {
                        Text(product.title)
                            .foregroundColor(.blue)
                            .font(.title2)
                        HStack {
                            //Image
                            AsyncImage(url: URL(string: product.image)) { img in
                                img.resizable().frame(width: 70, height: 70)
                                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                            } placeholder: {
                                ProgressView()
                            }
                            VStack(alignment: .leading) {
                                // Price
                                Text("$ \(String(format: "%.2f", product.price))")
                                    .foregroundColor(.green)
                                    .font(.title3)
                                // Description
                                Text(product.description)
                                    .font(.footnote)
                            }
                        }
                    }
                }
            }
            .onAppear {
                productsviewModel.loadProducts()
            }
            .navigationTitle("Products")
        }
    }
}

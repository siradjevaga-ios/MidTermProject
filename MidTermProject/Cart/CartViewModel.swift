//
//  CartViewModel.swift
//  MidTermProject
//
//  Created by user on 12.01.26.
//

import Foundation

class CartViewModel {
    private(set) var cartProducts: [Product] = []
    
    func addProduct(product: Product) {
        cartProducts.append(product)
    }
    
    func remove(at index: Int) {
        cartProducts.remove(at: index)
    }
    
    func numberOfItems() -> Int {
        cartProducts.count
    }
}

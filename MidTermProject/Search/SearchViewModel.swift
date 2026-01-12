//
//  SearchViewModel.swift
//  MidTermProject
//
//  Created by user on 12.01.26.
//

import Foundation

class SearchViewModel {
    private(set) var allProducts = [Product]()
    private(set) var filteredProducts = [Product]()
    
    
    func loadProduct() {
        allProducts = DataManager().getBagzItems()
        filteredProducts = allProducts
    }
    
    func search(text: String) {
        let searchText = text.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        if searchText.isEmpty {
            filteredProducts = allProducts
        } else {
            filteredProducts = allProducts.filter({ $0.name.lowercased().contains(searchText)})
        }
    }
}

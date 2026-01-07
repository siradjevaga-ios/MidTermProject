//
//  DataManager.swift
//  MidTermProject
//
//  Created by user on 06.01.26.
//

// DataManager handles products and basket logic
import Foundation

class DataManager {
    
    func getBagzItems() -> [Product] {
        guard let url = Bundle.main.url(forResource: "Products", withExtension: "json") else { return [] }
        do {
            let data = try Data(contentsOf: url)
            let products = try JSONDecoder().decode([Product].self, from: data)
            return products
        } catch {
            print(error.localizedDescription)
            return []
        }
        
    }
}

    // comment

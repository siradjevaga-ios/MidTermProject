//
//  WishListViewModel.swift
//  MidTermProject
//
//  Created by user on 10.01.26.
//

import UIKit
import CoreData



class WishListViewModel {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var items: [WishEntity] = []
    
    
     func fetchItems() {
        do {
            items = try context.fetch(WishEntity.fetchRequest())
        } catch {
            print(error.localizedDescription)
        }
    }
    
     func addItem(productId: Int64, userId: Int64) {
        let item = WishEntity(context: context)
        item.productId = productId
        item.userId = userId
        
        do {
            try context.save()
            items.append(item)
        } catch {
            print(error.localizedDescription)
        }
    }
    
     func deleteItem(at index: Int) {
        let item = items[index]
        context.delete(item)
        
        do {
            try context.save()
            items.remove(at: index)
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    func getProduct(at index: Int) -> Product? {
        let wishItem = items[index]
        let allProdcuts = DataManager().getBagzItems()
        return allProdcuts.first { $0.id == wishItem.productId }
    }
    
    func deleteItemByProductId(productId: Int64) {
        if let index = items.firstIndex(where: { $0.productId == productId }) {
            deleteItem(at: index)
        }
    }

    
}

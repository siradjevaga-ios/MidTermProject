//
//  WishListViewController.swift
//  MidTermProject
//
//  Created by user on 06.01.26.
//

import UIKit

class WishListViewController: UIViewController {
    private var allProducts = [Product]()
    private var wishListProducts = [Product]()
    private var wishList = "wishKey"

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
   

    
    private func getWishList() -> [Int] {
        UserDefaults.standard.array(forKey: wishList) as? [Int] ?? []
        
    }
    
    private func loadWishListProducts() {
        var wishIds = getWishList()
        wishListProducts = allProducts.filter({ product in
            wishIds.contains(product.id)
        })
    }


}

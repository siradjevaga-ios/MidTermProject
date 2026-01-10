//
//  WishListViewController.swift
//  MidTermProject
//
//  Created by user on 06.01.26.
//

import UIKit

class WishListViewController: UIViewController {
    
    
    @IBOutlet weak var collection: UICollectionView!
    
    private let viewModel = WishListViewModel()
    private var allProducts = [Product]()
    private var wishListProducts = [Product]()
    private let wishListKey = "wishList"

    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
        collection.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell")
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        allProducts = DataManager().getBagzItems()
        loadWishListProducts()
        collection.reloadData()
    }
    
    private func getWishListIds() -> [Int] {
        UserDefaults.standard.array(forKey: wishListKey) as? [Int] ?? []
    }

    
    private func loadWishListProducts() {
        let wishIds = getWishListIds()
        wishListProducts = allProducts.filter {
            wishIds.contains($0.id)
        }
    }


}

extension WishListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        wishListProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
        cell.configureUI(product: wishListProducts[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 168, height: 240)
    }
    
}

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


    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
        collection.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)


        viewModel.fetchItems()
        collection.reloadData()
    }
    
//    private func getWishListIds() -> [Int] {
//        UserDefaults.standard.array(forKey: wishListKey) as? [Int] ?? []
//    }

//    private func loadWishListProducts() {
//        let wishIds = getWishListIds()
//        wishListProducts = allProducts.filter {
//            wishIds.contains($0.id)
//        }
//    }


}

extension WishListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
        
        if let product = viewModel.getProduct(at: indexPath.row) {
       
            cell.configureUI(product: product, isLiked: true)
            cell.onHeartTapped = { [weak self] productId, isLiked in
                guard let self = self else { return }
                if !isLiked {
                    self.viewModel.deleteItemByProductId(
                        productId: Int64(productId)
                    )
                    self.collection.reloadData()
                }
            }
        }
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 168, height: 240)
    }
    
    
    
}

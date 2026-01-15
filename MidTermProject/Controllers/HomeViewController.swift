//
//  HomeViewController.swift
//  MidTermProject
//
//  Created by user on 06.01.26.
//

import UIKit

class HomeViewController: UIViewController {
  
    
    @IBOutlet weak var collection: UICollectionView!
    
    @IBOutlet weak var addToCartButton: UIButton!
//    private var selectedProductForCart: Product?
//    private var shouldShowAddToCartButton = false
    private var selectedCartProductIds = Set<Int>()

    private let wishViewModel = WishListViewModel()
    private var products = [Product]()
    private let dataManager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
        collection.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell")
        products = dataManager.getBagzItems()
        let header = HeaderView.load(imageName: "hero")
        
        view.addSubview(header)
        
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            header.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: view.trailingAnchor),
   
        ])
    }
    
    
    
    @IBAction func addToCartTapped(_ sender: Any) {
        let selectedProducts = products.filter { selectedCartProductIds.contains($0.id) }

            for product in selectedProducts {
                AppData.shared.cartViewModel.addProduct(product: product)
            }

            selectedCartProductIds.removeAll()
            addToCartButton.isHidden = true

            tabBarController?.selectedIndex = 3
        }
        
    }

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
        let product = products[indexPath.row]
        let isLiked = wishViewModel.items.contains {
            $0.productId == Int64(product.id)
        }
        cell.configureUI(product: product, isLiked: isLiked)
        
        cell.onHeartTapped = { [weak self] productId, isLiked in
            guard let self = self else { return }

            if isLiked {
                self.wishViewModel.addItem(productId: Int64(productId), userId: 0)
                self.selectedCartProductIds.insert(productId)
            } else {
                self.wishViewModel.deleteItemByProductId(productId: Int64(productId))
                self.selectedCartProductIds.remove(productId)
            }

            self.addToCartButton.isHidden = self.selectedCartProductIds.isEmpty
        }

        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 176, height: 240)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = products[indexPath.row]
        print(product.name)
    }


    
   
}


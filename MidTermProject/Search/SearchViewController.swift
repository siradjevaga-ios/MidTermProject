//
//  SearchViewController.swift
//  MidTermProject
//
//  Created by user on 06.01.26.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var collection: UICollectionView!
    
    @IBOutlet weak var addToCartButton: UIButton!
    
    private let viewModel = SearchViewModel()
    private let wishViewModel = WishListViewModel()
    private var selectedCartProductIds = Set<Int>()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        collection.delegate = self
        collection.dataSource = self
        collection.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell")
        viewModel.loadProduct()

    }
    
    @IBAction func addToCartTapped(_ sender: Any) {
        let selectedProducts = viewModel.filteredProducts.filter { selectedCartProductIds.contains($0.id) }
        
        for product in selectedProducts {
            AppData.shared.cartViewModel.addProduct(product: product)
        }
        
        selectedCartProductIds.removeAll()
        addToCartButton.isHidden = true
        
        tabBarController?.selectedIndex = 3
    }
    
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.filteredProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell

        let product = viewModel.filteredProducts[indexPath.row]

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
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(text: searchText)
        collection.reloadData()
    }
    
}

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
    
    private let viewModel = SearchViewModel()
    private let wishViewModel = WishListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        collection.delegate = self
        collection.dataSource = self
        collection.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell")
        viewModel.loadProduct()
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
                self.wishViewModel.addItem(
                    productId: Int64(productId),
                    userId: 0
                )
            } else {
                self.wishViewModel.deleteItemByProductId(
                    productId: Int64(productId)
                )
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 168, height: 240)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(text: searchText)
        collection.reloadData()
    }
    
}

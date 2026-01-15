//
//  WishListViewController.swift
//  MidTermProject
//
//  Created by user on 06.01.26.
//

import UIKit

class WishListViewController: UIViewController {
    
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var headerContainerView: UIView!
    @IBOutlet weak var addToCartButton: UIButton!
    
    private let viewModel = WishListViewModel()


    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
        collection.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell")
        
        let header = HeaderView.load(imageName: "wishlistHero")
            headerContainerView.addSubview(header)

            NSLayoutConstraint.activate([
                header.topAnchor.constraint(equalTo: headerContainerView.topAnchor),
                header.leadingAnchor.constraint(equalTo: headerContainerView.leadingAnchor),
                header.trailingAnchor.constraint(equalTo: headerContainerView.trailingAnchor),
                header.bottomAnchor.constraint(equalTo: headerContainerView.bottomAnchor)
            ])

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)


        viewModel.fetchItems()
        collection.reloadData()
        addToCartButton.isHidden = viewModel.items.isEmpty

    }
    
    

    
    @IBAction func addToCartTapped(_ sender: Any) {
        for i in 0..<viewModel.items.count {
            if let product = viewModel.getProduct(at: i) {
                AppData.shared.cartViewModel.addProduct(product: product)
            }
        }
        tabBarController?.selectedIndex = 3
    }
    
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
                    self.addToCartButton.isHidden = self.viewModel.items.isEmpty
                }
            }
        }
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 176, height: 240)
    }
    
    
    
}

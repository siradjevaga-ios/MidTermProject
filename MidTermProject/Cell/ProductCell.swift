//
//  ProductCell.swift
//  MidTermProject
//
//  Created by user on 07.01.26.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    private var isLiked = false
    private let wishKey = "wishList"
    private var productId: Int!


    
    @IBOutlet weak var bagzImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var heartButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureUI(product: Product) {
        productId = product.id
        nameLabel.text = product.name
        priceLabel.text = "\(product.price)₼"
        bagzImage.image = UIImage(named: product.imageName)
        let wishList = getWishList()
        isLiked = wishList.contains(product.id)
        updateHeart()
        
    }
    
    
    @IBAction func heartButtonTapped(_ sender: Any) {
        var wishlist = getWishList()
        if isLiked {
            wishlist.removeAll { $0 == productId }
        } else {
            wishlist.append(productId)
        }
        saveWishList(wishlist)
        isLiked.toggle()
        updateHeart()
    }
    
    func updateHeart() {
        let heartImage = isLiked ? "heart.fill" : "heart"
        heartButton.setImage(UIImage(systemName: heartImage), for: .normal)
    }
    
    private func saveWishList(_ list: [Int]) {
        UserDefaults.standard.set(list, forKey: wishKey)
    }
    
    private func getWishList() -> [Int] {
        UserDefaults.standard.array(forKey: wishKey) as? [Int] ?? []
    }
    
    
}

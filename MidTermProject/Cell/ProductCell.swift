//
//  ProductCell.swift
//  MidTermProject
//
//  Created by user on 07.01.26.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    @IBOutlet weak var bagzImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var heartButton: UIButton!
    
    var onHeartTapped: ((Int, Bool) -> Void)?
    private var isLiked = false
    private var productId: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureUI(product: Product, isLiked: Bool) {
        productId = product.id
        nameLabel.text = product.name
        priceLabel.text = "\(product.price)₼"
        bagzImage.image = UIImage(named: product.imageName)

        self.isLiked = isLiked
        updateHeart()
    }

    
    
    @IBAction func heartButtonTapped(_ sender: Any) {
        isLiked.toggle()
        updateHeart()
        onHeartTapped?(productId, isLiked)
    }
  

    
    func updateHeart() {
        let heartImage = isLiked ? "heart.fill" : "heart"
        heartButton.setImage(UIImage(systemName: heartImage), for: .normal)
    }
    
    
}

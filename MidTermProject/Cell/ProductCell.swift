//
//  ProductCell.swift
//  MidTermProject
//
//  Created by user on 07.01.26.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    private var isLiked = false
    
    @IBOutlet weak var bagzImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var heartButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureUI(product: Product) {
        nameLabel.text = product.name
        priceLabel.text = "\(product.price)₼"
        bagzImage.image = UIImage(named: product.imageName)
        
    }
    
    
    @IBAction func heartButtonTapped(_ sender: Any) {
        isLiked.toggle()
        updateHeart()
    }
    
    func updateHeart() {
        let heartImage = isLiked ? "heart.fill" : "heart"
        heartButton.setImage(UIImage(systemName: heartImage), for: .normal)
    }
    
    
    
}

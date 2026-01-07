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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureUI(product: Product) {
        nameLabel.text = product.name
        priceLabel.text = "\(product.price)₼"
        bagzImage.image = UIImage(named: product.imageName)
        
    }

}

//
//  HeaderView.swift
//  MidTermProject
//
//  Created by user on 12.01.26.
//

import UIKit

final class HeaderView: UIView {
    
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    static func load(title: String, imageName: String, height: CGFloat) -> HeaderView {
        let view = Bundle.main.loadNibNamed("HeaderView", owner: nil, options: nil)?.first as! HeaderView
        view.titleLabel.text = title
        view.backgroundImageView.image = UIImage(named: imageName)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([view.heightAnchor.constraint(equalToConstant: height)])
        return view
    }
}

//
//  HeaderView.swift
//  MidTermProject
//
//  Created by user on 12.01.26.
//

import UIKit

final class HeaderView: UIView {
    
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    static func load(imageName: String) -> HeaderView {
        let view = Bundle.main.loadNibNamed("HeaderView", owner: nil, options: nil)?.first as! HeaderView
        view.backgroundImageView.image = UIImage(named: imageName)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}

//
//  ProductDetailViewController.swift
//  MidTermProject
//
//  Created by user on 18.01.26.
//

import UIKit

final class ProductDetailViewController: UIViewController {
    private let product : Product
    
    init(product: Product) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

    }
}

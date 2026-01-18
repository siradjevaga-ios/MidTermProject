//
//  ProductDetailViewController.swift
//  MidTermProject
//
//  Created by user on 18.01.26.
//

import UIKit

final class ProductDetailViewController: UIViewController {
    private let product : Product
    
    private var productImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private var nameLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 24, weight: .bold)
        l.textAlignment = .center
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private var priceLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 20, weight: .bold)
        l.textAlignment = .center
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private var shortDescriptionLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = .italicSystemFont(ofSize: 16)
    
        l.textColor = .label
        return l
    }()
    
    private var detailDescriptionLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = .systemFont(ofSize: 16, weight: .medium)
        l.textColor = .systemGray
       
        return l
    }()
    
    private lazy var buyNow: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "buyNow"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
        return button
    }()

    
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
        configureUI()
        configureConstraint()
    }
    
    private func configureUI() {
        productImage.image = UIImage(named: product.imageName)
        nameLabel.text = product.name
        priceLabel.text = product.price
        shortDescriptionLabel.text = product.description
        detailDescriptionLabel.text = product.detailDescription
        view.addSubview(productImage)
        view.addSubview(nameLabel)
        view.addSubview(priceLabel)
        view.addSubview(shortDescriptionLabel)
        view.addSubview(detailDescriptionLabel)
        view.addSubview(buyNow)
        
    }
    
    private func configureConstraint() {
        NSLayoutConstraint.activate([
            productImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            productImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            productImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            productImage.heightAnchor.constraint(equalToConstant: 240),
            
            nameLabel.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 6),
            priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            priceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            shortDescriptionLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 12),
            shortDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            shortDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            detailDescriptionLabel.topAnchor.constraint(equalTo: shortDescriptionLabel.bottomAnchor, constant: 20),
            detailDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            detailDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            detailDescriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: buyNow.topAnchor, constant: -12),

            
            
            buyNow.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            buyNow.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buyNow.heightAnchor.constraint(equalToConstant: 52),
            buyNow.widthAnchor.constraint(equalToConstant: 240)
        ])
    }
    
    @objc private func addToCart() {
        AppData.shared.cartViewModel.addProduct(product: product)
        dismiss(animated: true)
    }
}

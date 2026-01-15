//
//  CartViewController.swift
//  MidTermProject
//
//  Created by user on 06.01.26.
//

import UIKit

class CartViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var headerContainerView: UIView!
    
    let cartViewModel = AppData.shared.cartViewModel
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        
        let header = HeaderView.load(imageName: "heroCartImage")
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
        table.reloadData()
        
    }

}


extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cartViewModel.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        let product = cartViewModel.product(at: indexPath.row)
        cell.textLabel?.text = product.name
        cell.detailTextLabel?.text = product.description
        cell.imageView?.image = UIImage(named: product.imageName)
        
        cell.detailTextLabel?.numberOfLines = 2
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            cartViewModel.remove(at: indexPath.row)
            table.deleteRows(at: [indexPath], with: .automatic)
        }
    
    }
}

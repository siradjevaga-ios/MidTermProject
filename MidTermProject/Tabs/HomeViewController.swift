//
//  HomeViewController.swift
//  MidTermProject
//
//  Created by user on 06.01.26.
//

import UIKit

class HomeViewController: UIViewController {
    private var products = [Product]()
    private let dataManager = DataManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        products = dataManager.getBagzItems()
        print(products.count)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

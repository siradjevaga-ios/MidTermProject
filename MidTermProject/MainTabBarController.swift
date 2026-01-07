//
//  MainTabBarController.swift
//  MidTermProject
//
//  Created by user on 05.01.26.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    private func configureUI() {
//        let home = HomeViewController()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let home = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController

        let search = SearchViewController()
        let wishList = WishListViewController()
        let cart = CartViewController()
        
        //Nav controller
        
        let homeNavigation = UINavigationController(rootViewController: home)
        let searchNavigation = UINavigationController(rootViewController: search)
        let wishListNavigation = UINavigationController(rootViewController: wishList)
        let cartNavigation = UINavigationController(rootViewController: cart)
        
        //Tabs image
        homeNavigation.tabBarItem.image = UIImage(systemName: "house")
        searchNavigation.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        wishListNavigation.tabBarItem.image = UIImage(systemName: "heart.fill")
        cartNavigation.tabBarItem.image = UIImage(systemName: "basket.fill")
        
        //Color
        
        tabBar.tintColor = .label
        tabBar.backgroundColor = .main
        
        // Set
        setViewControllers([homeNavigation, searchNavigation, wishListNavigation, cartNavigation], animated: true)


    }

}

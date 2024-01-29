//
//  GFTabBarViewController.swift
//  GHFFollowers
//
//  Created by 郭梓榕 on 29/1/2024.
//

import UIKit

class GFTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        UITabBar.appearance().tintColor = .systemGreen
        UITabBar.appearance().backgroundColor = .systemGray6
        
        self.viewControllers = [createSearchNC(), createFavoriteNC()]
    }
    // Set up SearchNC & SearchVC
    func createSearchNC() -> UINavigationController {
        
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchVC)
    }
    
    // Set up FavoriteListNC & FavoriteListVC
    func createFavoriteNC() -> UINavigationController {
        
        let favoriteListVC = FavoriteListVC()
        favoriteListVC.title = "Favorite"
        favoriteListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoriteListVC)
    }
}

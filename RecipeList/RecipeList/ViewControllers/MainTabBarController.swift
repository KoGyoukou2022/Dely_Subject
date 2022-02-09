//
//  TabBarControllerViewController.swift
//  RecipeList
//
//  Created by RLSUU210300 on 2022/02/06.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViewsToTabBar()
        
        setTabBarItemColor()
        
        // Do any additional setup after loading the view.
    }
    
    func setTabBarItemColor() {
        tabBar.backgroundColor = .white
        tabBar.unselectedItemTintColor = .lightGray
        tabBar.tintColor = .red
    }
    
    
    private func addViewsToTabBar() {
        let recipeVc = addChildVc(childVc: R.storyboard.recipeListViewController.instantiateInitialViewController()!, title: R.string.localizable.recipeListTabBarTitle(), image: R.image.btnRecipeListNormal(), selectedImage: R.image.btnRecipeListSelected())
        recipeVc.navigationItem.titleView?.isHidden = false
        
        let myFavoritesVc = addChildVc(childVc: R.storyboard.myFavoritesViewController.instantiateInitialViewController()!, title: R.string.localizable.myFavoritesTabBarTitle(), image: R.image.btnFavoriteNormal(), selectedImage: R.image.btnFavoriteSelected())
        myFavoritesVc.navigationItem.titleView?.isHidden = false
        
        viewControllers = [recipeVc, myFavoritesVc]
    }
    
    private func addChildVc(childVc: UIViewController, title: String, image: UIImage?, selectedImage: UIImage?) -> UINavigationController {
        let nav = MainNavigationController(rootViewController: childVc)
        let tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        nav.tabBarItem = tabBarItem
        
        return nav
    }
}

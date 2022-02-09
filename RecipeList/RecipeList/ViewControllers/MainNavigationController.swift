//
//  MainNavigationControllerViewController.swift
//  RecipeList
//
//  Created by RLSUU210300 on 2022/02/06.
//

import UIKit

class MainNavigationController: UINavigationController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if #available(iOS 15.0, *) {
        let app = UINavigationBarAppearance()
        app.configureWithOpaqueBackground()
        app.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
//        UINavigationBar.appearance().scrollEdgeAppearance = app
//        UINavigationBar.appearance().standardAppearance = app
        
//    }

        self.interactivePopGestureRecognizer?.delegate = self
        self.delegate = self
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            self.interactivePopGestureRecognizer?.isEnabled = true
        }
        super.pushViewController(viewController, animated: animated)
    }

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if navigationController.viewControllers.count == 1 {
            self.interactivePopGestureRecognizer?.isEnabled = false
        }
    }
}

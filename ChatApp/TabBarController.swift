//
//  TabBarController.swift
//  ChatApp
//
//  Created by Raluca Angheluta on 18/07/2017.
//  Copyright © 2017 Raluca Angheluta. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let item1 = MessagesController()
        let icon1 = UITabBarItem(title: "Title", image: UIImage(named: "Icon1.png"), selectedImage: UIImage(named: "Icon1.png"))
        item1.tabBarItem = icon1
        let controllers = [item1]
        viewControllers = controllers.map { UINavigationController(rootViewController: $0) }    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("Should select viewController: \(viewController.title ?? "") ?")
        return true;
    }
}

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
        //navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let item2 = UINavigationController(rootViewController: SettingsController())
        let item1 = UINavigationController(rootViewController: NewMessageController())
//        let item2 = SettingsController()
//        let item1 = NewMessageController()
        let icon1 = UITabBarItem(title: "Debates", image: #imageLiteral(resourceName: "Debate"), selectedImage: #imageLiteral(resourceName: "DebatePressed"))
        let icon2 = UITabBarItem(title: "Settings", image: #imageLiteral(resourceName: "settingsIcon"), selectedImage: #imageLiteral(resourceName: "settingsIconPressed"))
        
        item1.tabBarItem = icon1
        item2.tabBarItem = icon2
        
        let controllers = [item2, item1]
        self.viewControllers = controllers
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("Should select viewController: \(viewController.title ?? "") ?")
        return true;
    }
}

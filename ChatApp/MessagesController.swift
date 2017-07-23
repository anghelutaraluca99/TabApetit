
//
//  ViewController.swift
//  ChatApp
//
//  Created by Raluca Angheluta on 23/06/2017.
//  Copyright © 2017 Raluca Angheluta. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class MessagesController: UITableViewController {

    let navigationItemTitle = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        let image = UIImage(named: "newMessageIcon")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleNewMessage))
        checkIfUserIsLoggedIn()
        
    }
    
    func handleNewMessage(){
        let newMessageController = NewMessageController()
        let navController = UINavigationController(rootViewController: newMessageController)
        present(navController, animated: true, completion: nil)
        return
    }
    
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }
        else {
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: {
                (snapshot) in
                print(snapshot)
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    //self.navigationItem.title = dictionary["name"] as? String
                    //self.initNavigationItemTitleView(profileName: (dictionary["name"] as? String)!)
                    self.setupNavigationItemTitle(title: (dictionary["name"] as? String)!)
                }
            }, withCancel: nil)
        }
    }
    
    func setupNavigationItemTitle(title: String) {
        navigationItemTitle.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        navigationItemTitle.setTitleColor(UIColor.black, for: .normal)
        navigationItemTitle.setTitle(title, for: .normal)
        navigationItemTitle.addTarget(self, action: #selector(self.editProfile), for: .touchUpInside)
        self.navigationItem.titleView = navigationItemTitle
        
    }
  
    func editProfile() {
        let settingsController = SettingsController()
        present(settingsController, animated: true, completion: nil)
    }
    
    func handleLogout() {
        
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print (logoutError)
        }
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
    }
}


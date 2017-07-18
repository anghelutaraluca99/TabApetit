//
//  EditProfileControllerViewController.swift
//  ChatApp
//
//  Created by Raluca Angheluta on 07/07/2017.
//  Copyright © 2017 Raluca Angheluta. All rights reserved.
//

import UIKit
import QuartzCore
import Firebase
import FirebaseDatabase

class SettingsController: UIViewController{

    
    var user = User()
    
//    let changeProfileImageButton : UIButton = {
//       let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("Change picture", for: .normal)
//        button.setTitleColor(UIColor.blue, for: .normal)
//        button.backgroundColor = UIColor.purple
//        button.setTitleColor(UIColor.white, for: .normal)
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
//        button.layer.cornerRadius = 10
//        button.addTarget(self, action: #selector(handleSelectProfileImageView), for: .touchUpInside)
//        button.clipsToBounds = true
//        return button
//    }()
    
    let nameLabel : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 35)
        label.text = "Name"
        return label
    }()
    
    let profileImageView : UIImageView = {
       let imageView = UIImageView()
        imageView.layer.cornerRadius = 50
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "photo")
        imageView.isUserInteractionEnabled = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let logOutButton : UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.purple
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitle("Log Out", for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkIfUserIsLoggedIn()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView))
        profileImageView.addGestureRecognizer(tapGesture)
        
        view.addSubview(profileImageView)
        setupProfileImageView()
        view.addSubview(nameLabel)
        setupNameLabe()
        view.addSubview(logOutButton)
        setupLogOutButton()
        view.backgroundColor = UIColor.white
    }
    
    func setupLogOutButton() {
        logOutButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        logOutButton.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 12).isActive = true
        logOutButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        logOutButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func setupNameLabe() {
        nameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    func setupProfileImageView() {
        profileImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 24).isActive = true
        profileImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 100).isActive = true
        profileImageView.widthAnchor.constraint(lessThanOrEqualToConstant: 100).isActive = true
    }
      
    func handleBack() {
        self.dismiss(animated: true, completion: nil)
        return
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

    func fetchUserData() {
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }
        else {
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: {
                (snapshot) in
                print(snapshot)
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    self.nameLabel.text = dictionary["name"] as? String
                    if let link = dictionary["profileImageURL"] {
                        let Url = URL(string: link as! String)
                        URLSession.shared.dataTask(with: Url!, completionHandler: {(data, response, error) in
                            if error != nil {
                                print(error!)
                                return
                            }
                            DispatchQueue.main.async {
                                self.profileImageView.image = UIImage(data: data!)
                            }
                        }).resume()
                    } else {
                        print("Could not get picture link")
                    }
                }
            }, withCancel: nil)
        }
    }

    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }
    }
}

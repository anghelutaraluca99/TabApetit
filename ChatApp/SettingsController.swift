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
    
    let changeProfileImageButton : UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Change picture", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.titleLabel?.font = UIFont.italicSystemFont(ofSize: 18)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true

        return button
    }()
    
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
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.placeholder = "Say something about yourself"
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isHidden = true
        
        let myColor : UIColor = UIColor.lightGray
        textView.layer.borderColor = myColor.cgColor
        textView.layer.borderWidth = 1
        
        return textView
    }()
    
    let uploadButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.purple
        button.setTitle("Save", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let logOutButton : UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor.purple
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("Log Out", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
        
        view.addSubview(descriptionTextView)
        setupDescriptionTextView()
        view.addSubview(uploadButton)
        view.addSubview(profileImageView)
        setupProfileImageView()
        view.addSubview(nameLabel)
        setupNameLabe()
        view.addSubview(changeProfileImageButton)
        setupChangeProfileImageButton()
        view.addSubview(logOutButton)
        setupLogOutButton()
        view.backgroundColor = UIColor.white
        //fetchUserData()
    }
    
    func setupLogOutButton() {
        logOutButton.leftAnchor.constraint(equalTo: profileImageView.leftAnchor).isActive = true
        logOutButton.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 60).isActive = true
        logOutButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        logOutButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }

    func setupChangeProfileImageButton() {
        changeProfileImageButton.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8).isActive = true
        changeProfileImageButton.leftAnchor.constraint(equalTo: profileImageView.leftAnchor, constant: -20).isActive = true
        changeProfileImageButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        changeProfileImageButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
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
    
    func setupDescriptionTextView() {
        descriptionTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        descriptionTextView.topAnchor.constraint(equalTo: view.topAnchor, constant: 85).isActive = true
        descriptionTextView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -48).isActive = true
        descriptionTextView.heightAnchor.constraint(equalToConstant: 160).isActive = true
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
                    //self.navigationItem.title = dictionary["name"] as? String
                    //self.initNavigationItemTitleView(profileName: (dictionary["name"] as? String)!)
                    self.nameLabel.text = dictionary["name"] as? String
                    
                    if let link = dictionary["profileImageURL"] {
                        let Url = URL(string: link as! String)
                        URLSession.shared.dataTask(with: Url!, completionHandler: {(data, response, error) in
                            if error != nil {
                                print(error!)
                                return
                            }
                            
                            print(link)
                            
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

    func handleDescriptionUpdate() {
        
        
            //      SOME WORK TO DO HERE
        return
    }
    

}

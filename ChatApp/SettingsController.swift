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
    
    let inputsContainerView: UIView = {
        let view = UIView();
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    let separator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(colorLiteralRed: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()//Second Separator
    
    let inputsContainerView2: UIView = {
        let view = UIView();
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    let nameLabel : UILabel = {
       let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.text = "Raluca Angheluta"
        return label
    }()
    
    let profileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "addProfilePicture")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 50
        imageView.isUserInteractionEnabled = true
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let logOutButton : UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.contentHorizontalAlignment = .left
        button.setTitle("   Log Out", for: .normal)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        return button
    }()
    
    let changeProfilePictureButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.contentHorizontalAlignment = .left
        button.setTitle("   Change profile picture", for: .normal)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleSelectProfileImageView), for: .touchUpInside)
        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(colorLiteralRed: 226/255, green: 226/255, blue: 226/255, alpha: 1)

        navigationItem.title = "Settings"
        checkIfUserIsLoggedIn()

        view.addSubview(inputsContainerView)
        setupInputsContainerView()
        view.addSubview(inputsContainerView2)
        setupInputsContainerView2()
        inputsContainerView.addSubview(profileImageView)
        setupProfileImageView()
        inputsContainerView.addSubview(nameLabel)
        setupNameLabe()
        inputsContainerView2.addSubview(logOutButton)
        setupLogOutButton()
        inputsContainerView2.addSubview(separator)
        setupSeparator()
        inputsContainerView2.addSubview(changeProfilePictureButton)
        setupChangeProfilePictureButton()
        fetchUserData()
    }
    
    func setupSeparator(){
        separator.leftAnchor.constraint(equalTo: inputsContainerView2.leftAnchor,  constant: 6).isActive = true
        separator.topAnchor.constraint(equalTo: logOutButton.bottomAnchor, constant: 3).isActive = true
        separator.widthAnchor.constraint(equalTo: inputsContainerView2.widthAnchor, constant: -12).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    func setupInputsContainerView(){
        inputsContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        inputsContainerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        inputsContainerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    func setupInputsContainerView2(){
        inputsContainerView2.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 24).isActive = true
        inputsContainerView2.heightAnchor.constraint(equalToConstant: 80).isActive = true
        inputsContainerView2.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        inputsContainerView2.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    func setupLogOutButton() {
        logOutButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        logOutButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        logOutButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 24).isActive = true
        logOutButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    func setupChangeProfilePictureButton() {
        changeProfilePictureButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        changeProfilePictureButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        changeProfilePictureButton.topAnchor.constraint(equalTo: logOutButton.bottomAnchor, constant: 5).isActive = true
        changeProfilePictureButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    func setupNameLabe() {
        nameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
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

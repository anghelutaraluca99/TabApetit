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

class EditProfileController: UIViewController{

    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.placeholder = "Say something about yourself"
        textView.translatesAutoresizingMaskIntoConstraints = false
        
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
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "This is the label"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleBack))
        navigationItem.title = "Nume"
        
        view.addSubview(descriptionTextView)
        setupDescriptionTextView()
        view.addSubview(uploadButton)
        setupUploadButton()
        view.addSubview(descriptionLabel)
        setupDescriptionLabel()
        view.backgroundColor = UIColor.white
    }
    
    func setupDescriptionTextView() {
        descriptionTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        descriptionTextView.topAnchor.constraint(equalTo: view.topAnchor, constant: 85).isActive = true
        descriptionTextView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -48).isActive = true
        descriptionTextView.heightAnchor.constraint(equalToConstant: 160).isActive = true
    }
    
    func setupUploadButton() {
        uploadButton.rightAnchor.constraint(equalTo: descriptionTextView.rightAnchor).isActive = true
        uploadButton.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 15).isActive = true
        uploadButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        uploadButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    func setupDescriptionLabel() {
        descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: uploadButton.bottomAnchor, constant: 15).isActive = true
        descriptionLabel.widthAnchor.constraint(equalTo: descriptionTextView.widthAnchor).isActive = true
        descriptionLabel.heightAnchor.constraint(equalTo: descriptionTextView.heightAnchor).isActive = true
    }
    
    func handleBack() {
        self.dismiss(animated: true, completion: nil)
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
                    self.navigationItem.title = (dictionary["name"] as? String)!
                }
            }, withCancel: nil)
        }
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

    
    func handleDescriptionUpdate() {
        
        
            //      SOME WORK TO DO HERE
        return
    }
    

}

//
//  EditProfileControllerViewController.swift
//  ChatApp
//
//  Created by Raluca Angheluta on 07/07/2017.
//  Copyright © 2017 Raluca Angheluta. All rights reserved.
//

import UIKit
import QuartzCore

class EditProfileController: UINavigationController{

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
        button.addTarget(self, action: #selector(handleDescriptionUpdate), for: .touchUpInside)
        return button
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "This is the label"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let getDescription = RestAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(descriptionTextView)
        setupDescriptionTextView()
        view.addSubview(uploadButton)
        setupUploadButton()
        view.addSubview(descriptionLabel)
        setupDescriptionLabel()
        view.backgroundColor = UIColor.white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleBack))

        

        //     NU MERGEEEE!!!!!!!!!     ->     Cancel Button
    }
    
    func setupDescriptionTextView() {
        descriptionTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        descriptionTextView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 40).isActive = true
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
        let messagesController = MessagesController()
        present(messagesController, animated: true, completion: nil)
        return
    }
    
    func handleDescriptionUpdate() {
        let jsonURLString = "http://www.json-generator.com/api/json/get/cemCHSnlLm?indent=2"
        getDescription.downloadApi(String: jsonURLString)
        
        
        
        //          DE INLOCUIT TIMER!!!!!!!!!!!!!!!!!!!
        
        
        var timer = Timer()
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(delayedAction), userInfo: nil, repeats: false)
        return
    }
    
     func delayedAction() {
        descriptionLabel.text = getDescription.user.name
    }

}

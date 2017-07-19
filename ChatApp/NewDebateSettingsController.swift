//
//  NewDebateSettingsController.swift
//  ChatApp
//
//  Created by Raluca Angheluta on 19/07/2017.
//  Copyright © 2017 Raluca Angheluta. All rights reserved.
//

import UIKit
import GooglePlaces

class NewDebateSettingsController: UIViewController {

    var placeName = String()
    var placeLong = CLLocationDegrees()
    var placeLat = CLLocationDegrees()
    
    let placeLabelTitle : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Where: "
        return label
    }()
    
    let dateLabelTitle : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Date: "
        return label
    }()
    
    let timeLabelTitle : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Time: "
        return label
    }()
    
    let themeLabelTitle : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Theme: "
        return label
    }()
    
    let placeLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateTextField : UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "dd/mm/yy"
        return textField
    }()
    
    let timeTextField : UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "12:00"
        return textField
    }()
    
    let themeTextField : UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Theme"
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "confirmIcon"), style: .plain, target: self, action: #selector(handleConfirm))
        
        placeLabel.text = placeName
        view.addSubview(placeLabel)
        setupPlaceLabel()
        view.addSubview(placeLabelTitle)
        setupPlaceLabelTitle()
        view.addSubview(dateLabelTitle)
        setupDateLabelTitle()
        view.addSubview(themeLabelTitle)
        setupThemeLabelTitle()
        view.addSubview(timeLabelTitle)
        setupTimeLabelTitle()
        view.addSubview(dateTextField)
        setupDateTextField()
        view.addSubview(timeTextField)
        setupTimeTextField()
        view.addSubview(themeTextField)
        setupThemeTextField()
    }
    
    func setupPlaceLabel() {
        placeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 110).isActive = true
        placeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        placeLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        placeLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }

    func setupDateTextField() {
        dateTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 110).isActive = true
        dateTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 90).isActive = true
        dateTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        dateTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }

    func setupTimeTextField() {
        timeTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 110).isActive = true
        timeTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        timeTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        timeTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }

    func setupThemeTextField() {
        themeTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 110).isActive = true
        themeTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        themeTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        themeTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }

    
    func setupPlaceLabelTitle() {
        placeLabelTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        placeLabelTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        placeLabelTitle.heightAnchor.constraint(equalToConstant: 50).isActive = true
        placeLabelTitle.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }

    func setupDateLabelTitle() {
        dateLabelTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        dateLabelTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 90).isActive = true
        dateLabelTitle.heightAnchor.constraint(equalToConstant: 50).isActive = true
        dateLabelTitle.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }

    func setupTimeLabelTitle() {
        timeLabelTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        timeLabelTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        timeLabelTitle.heightAnchor.constraint(equalToConstant: 50).isActive = true
        timeLabelTitle.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    func setupThemeLabelTitle() {
        themeLabelTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        themeLabelTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        themeLabelTitle.heightAnchor.constraint(equalToConstant: 50).isActive = true
        themeLabelTitle.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    func handleConfirm() {
        
    }
    
    func handleCancel() {
        self.dismiss(animated: true, completion: nil)
    }

}

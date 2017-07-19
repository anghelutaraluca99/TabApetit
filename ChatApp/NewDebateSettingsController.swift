//
//  NewDebateSettingsController.swift
//  ChatApp
//
//  Created by Raluca Angheluta on 19/07/2017.
//  Copyright © 2017 Raluca Angheluta. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import Firebase

class NewDebateSettingsController: UIViewController {

    var placeName = String()
    var placeLong = CLLocationDegrees()
    var placeLat = CLLocationDegrees()
    let datePicker = UIDatePicker()
    let timePicker = UIDatePicker()
    var refDebates = DatabaseReference()
    
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
        textField.placeholder = "mm/dd/yy"
        textField.addTarget(self, action: #selector(createDatePickerToolbar), for: .touchDown)
        return textField
    }()
    
    let timeTextField : UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "12:00"
        textField.addTarget(self, action: #selector(createTimePickerToolbar), for: .touchDown)
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
    
    func handleConfirm() {
        let ref = Database.database().reference(fromURL: "https://chatapp-ed83f.firebaseio.com/")
        let key = NSUUID().uuidString
        print(key)
        refDebates = ref.child("Debates").child(key)
        
        let debate = ["id" : key,
                      "placeName" : self.placeName as String,
                      "placeLat" : self.placeLat as CLLocationDegrees,
                      "placeLong" : self.placeLong as CLLocationDegrees,
                      "date" : dateTextField.text!,
                      "time" : timeTextField.text!,
                      "theme": themeTextField.text!,
                      "numberOfParticipants": 1 as Int] as [String : Any]
        if Auth.auth().currentUser?.uid != nil {
            refDebates.updateChildValues(debate, withCompletionBlock: {(error2, ref) in
                if error2 != nil{
                    print(error2!)
                    return
                }
                self.dismiss(animated: true, completion: nil)
                print("Debate saved succesfuly into the Firebase database!")
            })
        }
    }
    
    func donePressed1() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateTextField.text = dateFormatter.string(from: datePicker.date)
        datePicker.endEditing(true)
    }
    
    func donePressed2() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        timeTextField.text = dateFormatter.string(from: timePicker.date)
        timePicker.endEditing(true)
    }
    
    func createTimePickerToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        timePicker.datePickerMode = UIDatePickerMode.time
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed2))
        toolbar.setItems([doneItem], animated: true)
        timeTextField.inputAccessoryView = toolbar
        timeTextField.inputView = timePicker
    }
    
    func createDatePickerToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        datePicker.datePickerMode = UIDatePickerMode.date
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed1))
        toolbar.setItems([doneItem], animated: true)
        dateTextField.inputAccessoryView = toolbar
        dateTextField.inputView = datePicker
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
    
    func handleCancel() {
        self.dismiss(animated: true, completion: nil)
    }

}

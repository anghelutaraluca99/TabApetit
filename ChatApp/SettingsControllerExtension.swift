//
//  TabBarControllerExtension.swift
//  ChatApp
//
//  Created by Raluca Angheluta on 18/07/2017.
//  Copyright © 2017 Raluca Angheluta. All rights reserved.
//

import UIKit
import Firebase

extension SettingsController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func handleSelectProfileImageView() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[String: AnyObject]){
        //print(info)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        //print(info)
        if let editedImage = info["UIImagePickedControllerEditedImage"]{
            profileImageView.image = (editedImage as! UIImage)
        }
        else if let originalImage = info["UIImagePickerControllerOriginalImage"]{
            //print(originalImage.size)
            profileImageView.image = (originalImage as! UIImage)
        }
        let ref = Database.database().reference(fromURL: "https://chatapp-ed83f.firebaseio.com/").child("users/").child((Auth.auth().currentUser?.uid)!)
        let imageName = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child("Profile Images").child("\(imageName).png")
        let uploadData = UIImagePNGRepresentation(self.profileImageView.image!)
        storageRef.putData(uploadData!, metadata: nil, completion: {(metadata, error) in
            if error != nil{
                print(error!)
                return
            }
            else
                if (metadata?.downloadURL()?.absoluteString) != nil {
                    ref.updateChildValues(["profileImageURL": metadata?.downloadURL()?.absoluteString])
                    print("Profile picture updated!")
            }
        })

        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //print("canceled picker")
        dismiss(animated: true, completion: nil)
    }
}

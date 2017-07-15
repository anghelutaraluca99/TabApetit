//
//  LoginController+handlers.swift
//  ChatApp
//
//  Created by Raluca Angheluta on 25/06/2017.
//  Copyright © 2017 Raluca Angheluta. All rights reserved.
//

import UIKit

extension LoginController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
 
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
        self.dismiss(animated: true, completion: nil)
    }


    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //print("canceled picker")
        dismiss(animated: true, completion: nil)
    }
}

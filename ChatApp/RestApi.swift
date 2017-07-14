//
//  RestApi.swift
//  ChatApp
//
//  Created by Raluca Angheluta on 09/07/2017.
//  Copyright © 2017 Raluca Angheluta. All rights reserved.
//

import Foundation
import UIKit

//class myUser {
//    var name: String?
//    var email: String?
//    var profileImageURL: String?
//    var Description: String?
//    
//    init(name : String, email : String, profileImageURL : String, Description : String){
//        self.name = name
//        self.email = email
//        self.profileImageURL = profileImageURL
//        self.Description = Description
//    }
//    
//    func getFromJson(json: [String: Any]) {
//        name = json["name"] as? String ?? ""
//        email = json["email"] as? String ?? ""
//        profileImageURL = json["profileImageURL"] as? String ?? ""
//        Description = json["Descriptiom"] as? String ?? ""
//    }
//}


class RestAPI {
    
    var user: User
    var group : DispatchGroup
    
    
    init() {
        user = User.init()
        group = DispatchGroup()
    }
    
    func downloadApi(String : String) {
        
        let jsonURL = URL(string: String)
        
        let session = URLSession.shared
        let task = session.dataTask(with: jsonURL!, completionHandler: {(data, response, error) in
            
            self.group.enter()
            
            if error != nil {
                print(error!)
                return
            }
                
            guard let data = data else {return}
            do{
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any] else {return}
                self.user.getFromJson(json: json)
                print(self.user.Description)
                return
            } catch let jsonError {
                print("Error serializing json: ", jsonError)
            }

        })
        
        DispatchQueue.main.async {
            task.resume()
        }
        return
    }
    
    func uploadAPI() {
        
    }
    
    
    
    
}

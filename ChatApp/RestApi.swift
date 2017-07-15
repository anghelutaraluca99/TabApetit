//
//  RestApi.swift
//  ChatApp
//
//  Created by Raluca Angheluta on 09/07/2017.
//  Copyright © 2017 Raluca Angheluta. All rights reserved.
//

import Foundation
import UIKit

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
            
            if let response = response {
                print(response)
                return
            }
                
            guard let data = data else {return}
            do{
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any] else {return}
                self.user.getFromJson(json: json)
                return
            } catch let jsonError {
                print("Error serializing json: ", jsonError)
            }

        })
        task.resume()
        
        return
    }
    
    func uploadAPI(description : String ) {
       
        let parameters = ["email" : user.email, "name" : user.name, "description" : user.Description]
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {return}
        request.httpBody = httpBody
        let session = URLSession.shared
        session.dataTask(with: request, completionHandler: {(data, response, error) in
            
            if let response = response {
                print(response)
                return
            }
            
            if error != nil {
                print(error!)
                return
            }
            
            do{
                let json = try JSONSerialization.data(withJSONObject: data!, options: [])
                print(json)
            } catch let error{
                print(error)
            }
        }).resume()
    }
    
}

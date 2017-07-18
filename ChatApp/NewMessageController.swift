//
//  NewMessageController.swift
//  ChatApp
//
//  Created by Raluca Angheluta on 23/06/2017.
//  Copyright © 2017 Raluca Angheluta. All rights reserved.
//

import UIKit
import Firebase

class NewMessageController: UITableViewController{

    let cellId = "cellId"
    var users = [User]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem =  UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New", style: .plain, target: self, action: #selector(handleNewDebate))
        tableView.register(userCell.self, forCellReuseIdentifier: cellId)
        fetchUser()
    }
    
    func handleNewDebate() {
        let newDebateController = NewDebateController()
        let navController = UINavigationController(rootViewController: newDebateController)
        present(navController, animated: true, completion: nil)
    }
    
    func fetchUser() {
      
        Database.database().reference().child("users").observe(.childAdded, with: {(snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject]{
                let user = User()
                //user.setValuesForKeys(dictionary) //app might crash if the values are not in the proper order
                user.name = (dictionary["name"] as? String)!
                user.email = (dictionary["email"] as? String)!
                user.profileImageURL = (dictionary["profileImageURL"] as? String)!
                self.users.append(user)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }//dispatch async needed othervise app crashes
                
                print(user.name!  , user.email!)
            }
        }, withCancel: nil)
        
    }
    
    func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }//gets the number of users
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        cell.imageView?.image = UIImage(named: "addProfilePicture")
        if let profileImageUrl = user.profileImageURL {
            let Url = URL(string: profileImageUrl)
            URLSession.shared.dataTask(with: Url!, completionHandler: {(data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                DispatchQueue.main.async {
                     cell.imageView?.image = UIImage(data: data!)
                }
            }).resume()
        }
        
        return cell
    }//show users + emails
    
}

class userCell: UITableViewCell  {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init (coder: ) has not been implemented")
    }
    
    
}

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
    var debates = [Debate]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New", style: .plain, target: self, action: #selector(handleNewDebate))
        navigationItem.title = "Current reservations"
        tableView.register(debateCell.self, forCellReuseIdentifier: cellId)
        fetchDebate()
    }
    
    func handleNewDebate() {
        let newDebateController = NewDebateController()
        let navController = UINavigationController(rootViewController: newDebateController)
        present(navController, animated: true, completion: nil)
    }
    
    func fetchDebate() {
        Database.database().reference().child("Debates").observe(.childAdded, with: {(snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject]{
                
                let debate = Debate()
                debate.placeName = (dictionary["placeName"] as? String)
                debate.placeLat = (dictionary["placeLat"] as? CLLocationDegrees)
                debate.placeLong = (dictionary["placeLong"] as? CLLocationDegrees)
                debate.date = (dictionary["date"] as? String)
                debate.time = (dictionary["time"] as? String)
                debate.numberOfParticipants = (dictionary["numberOfParticipants"] as? Int)
                debate.theme = (dictionary["theme"] as? String)
                debate.id = (dictionary["id"] as? String)
                self.debates.append(debate)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }//dispatch async needed othervise app crashes
            }
        }, withCancel: nil)
        
    }
    
    func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return debates.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let debate = debates[indexPath.row]
        cell.textLabel?.text = debate.theme
        cell.detailTextLabel?.text = debate.date
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 16)
        
//        let user = users[indexPath.row]
//        cell.textLabel?.text = user.name
//        cell.detailTextLabel?.text = user.email
//        cell.imageView?.image = UIImage(named: "addProfilePicture")
//        if let profileImageUrl = user.profileImageURL {
//            let Url = URL(string: profileImageUrl)
//        
//            
        
//            URLSession.shared.dataTask(with: Url!, completionHandler: {(data, response, error) in
//                if error != nil {
//                    print(error!)
//                    return
//                }
//                DispatchQueue.main.async {
//                     cell.imageView?.image = UIImage(data: data!)
//                }
//            }).resume()
            
            // UNCOMMENT LATER !!!!!!!!!!!!!!!
            
//        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let cell = tableView.cellForRow(at: indexPath)
            print(cell?.textLabel?.text as Any)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        
        let debate = debates[editActionsForRowAt.row]
        let ref = Database.database().reference(fromURL: "https://chatapp-ed83f.firebaseio.com/").child("Debates")
        
        let participate = UITableViewRowAction(style: .normal, title: "Enter") { action, index in
            let refUpdate = ref.child("\(debate.id!)")
            refUpdate.updateChildValues(["numberOfParticipants" : (debate.numberOfParticipants! + 1)])
            ref.child("participants").updateChildValues(["\(debate.numberOfParticipants! + 1)" : Auth.auth().currentUser?.uid])
            
            //gotta do some work here
            print("Updated!")
        }
        participate.backgroundColor = .red
        
        let details = UITableViewRowAction(style: .normal, title: "Details") { action, index in
            let detailsViewController = DetailsViewController()
            detailsViewController.time = debate.time!
            detailsViewController.placeLat = debate.placeLat!
            detailsViewController.placeLong = debate.placeLong!
            detailsViewController.date = debate.date!
            let navController = UINavigationController(rootViewController: detailsViewController)
            self.present(navController, animated: true, completion: nil)
        }
        details.backgroundColor = .lightGray
        
        return [participate, details]
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
}

class debateCell: UITableViewCell  {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init (coder: ) has not been implemented")
    }
    
    
}

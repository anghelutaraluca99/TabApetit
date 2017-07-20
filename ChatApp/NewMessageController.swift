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
        navigationItem.title = "Current Debates"
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
                self.debates.append(debate)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }//dispatch async needed othervise app crashes
                
                print(debate.placeName!  , debate.theme!)
            }
        }, withCancel: nil)
        
    }
    
    func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return debates.count
    }//gets the number of users
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let debate = debates[indexPath.row]
        cell.textLabel?.text = debate.theme! + " at " + debate.placeName!
        cell.detailTextLabel?.text = debate.time
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 12)
        
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
            print(cell?.textLabel?.text)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        
        let debate = debates[editActionsForRowAt.row]
        debate.participants?.append((Auth.auth().currentUser?.uid)!)
        let ref = Database.database().reference(fromURL: "https://chatapp-ed83f.firebaseio.com/").child("Debates")
        
        let participate = UITableViewRowAction(style: .normal, title: "Enter") { action, index in
            let refUpdate = ref.child(debate.id!)
            ref.child("numberOfParticipants").updateChildValues(["numberOfParticipants" : (debate.numberOfParticipants! + 1)])
            //ref.child("participants").updateChildValues(["participants" : debate.participants])
            print("Updated!")
        }
        participate.backgroundColor = .red
        
        let seeParticipants = UITableViewRowAction(style: .normal, title: "Others") { action, index in
            print("user chose to see who else participates")
        }
        seeParticipants.backgroundColor = .orange
        
        let details = UITableViewRowAction(style: .normal, title: "Details") { action, index in
            print("share button tapped")
        }
        details.backgroundColor = .lightGray
        
        return [participate, seeParticipants, details]
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

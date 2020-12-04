//
//  QueueVC.swift
//  RoadTrip
//
//  Created by Chanmin Park on 12/4/20.
//

import Foundation
import Firebase

class SongTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
}

class QueueVC: UITableViewController, AddToQueueDelegate {
    let db = Firestore.firestore()
    lazy var accountsRef = db.collection("accounts")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("reached")
    }
    
    
    
    func songAdded() {
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "queueTemplate", for: indexPath) as! SongTableViewCell
        
        let (songTitle, songArtist, songImageURI) = getSongFromQueue(index: indexPath.row)
        
        cell.artistLabel?.text = songArtist
        print("songARtist\(songArtist)")
        cell.titleLabel?.text = songTitle
        //cell.imageLabel
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getQueueCount()
    }
    
        func getSongFromQueue(index: Int) -> (String, String, String) {
            var songTitle = ""
            var songArtist = ""
            var songImageURI = ""
            let currAccount = accountsRef.document(user.accountRefID)
            currAccount.getDocument { (doc, err) in
                if let err = err {
                    print("Error checking for username: \(err)")
                } else {
                    if let doc = doc {
                        let queue = doc.get("queue") as! Array<Dictionary<String, Any>>
                        for (key, value) in queue[index] {
                            if key == "title" {
                                songTitle = value as! String
                            }
                            if key == "artist" {
                                songArtist = value as! String
                            }
                            if key == "imageURI" {
                                songImageURI = value as! String
                            }

                        }
                    }
                }
            }
        
        return (songTitle, songArtist, songImageURI)
        }
    
    func getQueueCount() -> Int {
        var count = 0
        let currAccount = accountsRef.document(user.accountRefID)
        currAccount.getDocument { (doc, err) in
            if let err = err {
                print("Error checking for username: \(err)")
            } else {
                if let doc = doc {
                    let queue = doc.get("queue") as! Array<Dictionary<String,Any>>
                    print(queue.count)
                    //return count
//                    for _ in queue. {
//                        count += 1
//                    }
                }
            }
        }
        //print("count \(count)")
        return count
    }
    
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 30.0
//    }
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if section == 0 {
//            return "Up Next"
//        } else {
//            return ""
//        }
//    }
}

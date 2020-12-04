//
//  TabBarVC.swift
//  RoadTrip
//
//  Created by Chanmin Park on 12/3/20.
//

import Foundation
import Combine
import SpotifyWebAPI
import Firebase

//var currUser = User(name: "", isMusicPlayer: true, accountRefID: "")

class TabBarVC: UITabBarController {
    
    let db = Firestore.firestore()
    lazy var accountsRef = db.collection("accounts")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.modalPresentationStyle = .fullScreen
        //self.present(self, animated: true, completion: nil)
        //let dispatchGroup = DispatchGroup()
        sharedSpotifyAPI.authorize()
        print(user.accountRefID)
        print(user.name)
        
        
        let currAccount = accountsRef.document(user.accountRefID)
//        currAccount.getDocument { (doc, err) in
//            if let err = err {
//                print("Error checking for username: \(err)")
//            } else {
//                //print(doc)
//                if let doc = doc {
//                    let queue = doc.get("queue") as! Array<Dictionary<String, Any>>
//                    //let song = queue[0].
//                    for (_, value) in queue[0] {
//                        print(value)
//                    }
//                }
//            }
//        }
        
        
    }

    //var user: User = User(name: "", isMusicPlayer: true, accountRefID: "")
    

}

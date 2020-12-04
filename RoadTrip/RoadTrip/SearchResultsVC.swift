//
//  QueueVC.swift
//  RoadTrip
//
//  Created by Chanmin Park on 12/4/20.
//

import Foundation
import Firebase

protocol AddToQueueDelegate: class {
    func songAdded()
}

class SearchResultsVC: UITableViewController {
    var songTracks = [SongTrack]()
    var rowSelected = 0
    
    weak var delegate: AddToQueueDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search Results"
        print(songTracks.count)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songTracks.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "track_template", for: indexPath)
        
        let track = songTracks[indexPath.row]
        cell.textLabel?.text = track.title
        cell.detailTextLabel?.text = track.artist
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rowSelected = indexPath.row
        
        
        let db = Firestore.firestore()
        let accountsRef = db.collection("accounts")
        
        let track = songTracks[indexPath.row]
        
        let trackAddQueue: [String: Any] = [
            "title": track.title,
            "artist": track.artist ?? NSNull(),
            "uri": track.uri,
            "popularity": track.popularity ?? NSNull(),
            "imageURI": track.imageURI ?? NSNull()
        ]
        
        accountsRef.document(user.accountRefID).updateData([
            "queue": FieldValue.arrayUnion([trackAddQueue])
        ])
        
        songTracks.remove(at: indexPath.row)
        self.tableView.reloadData()
        self.delegate?.songAdded()
    }
    
//    @objc
//    func imgTap(tapGesture: UITapGestureRecognizer) {
//           let imgView = tapGesture.view as! UIImageView
//           let idToMove = imgView.tag
//          //Do further execution where you need idToMove
//
//       }
    
    
}

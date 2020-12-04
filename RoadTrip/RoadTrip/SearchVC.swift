//
//  QueueVC.swift
//  RoadTrip
//
//  Created by Chanmin Park on 12/4/20.
//

import Foundation

class SearchVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search"
    }
    
    @IBOutlet weak var searchInput: UITextField!
    
    @IBOutlet weak var category: UISegmentedControl!
    
    @IBAction func search(_ sender: Any) {
        if searchInput.text == "" {
            showErrorMessage()
            return
        }
        
        self.performSegue(withIdentifier: "showSearchResults", sender: self)
    }
    
    func showErrorMessage() {
        let alert = UIAlertController(title: "Try again!", message: "Please write in the search box", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSearchResults" {
            let vc = segue.destination as! SearchResultsVC
            
            vc.songTracks = sharedSpotifyAPI.search(input: searchInput.text!, category: category.selectedSegmentIndex)

        }
    }
}

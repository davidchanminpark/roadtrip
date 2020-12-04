//
//  createNameVC.swift
//  RoadTrip
//
//  Created by Chanmin Park on 12/3/20.
//

import Foundation
import Firebase

var user = User(name: "", isMusicPlayer: false, accountRefID: "")

class CreateNameVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var isMusicPlayer: Bool = true
    var carAccountID = ""
    
    @IBOutlet weak var nameInput: UITextField!
    
    @IBAction func goToApp(_ sender: Any) {
        if nameInput.text == "" {
            showErrorMessage()
            return
        }
        let db = Firestore.firestore()
        let accountsRef = db.collection("accounts")
        
        user = User(name: nameInput.text!, isMusicPlayer: isMusicPlayer, accountRefID: carAccountID)
        
        let newData: [String: Any] = [
            "name": user.name,
            "isMusicPlayer": user.isMusicPlayer
        ]
        
        accountsRef.document(carAccountID).updateData([
            "users": FieldValue.arrayUnion([newData])
        ])
        
        
        self.performSegue(withIdentifier: "goToMainPage", sender: self)

    }
    
    func showErrorMessage() {
        let alert = UIAlertController(title: "Try Again!", message: "Your name has to have at least one character..", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "" {
//            let vc = segue.destination as! TabBarVC
//            vc.user = User(name: nameInput.text!, isMusicPlayer: isMusicPlayer, accountRefID: carAccountID )
//        }
//    }
    
    
}

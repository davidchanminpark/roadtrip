//
//  CreateAccountVC.swift
//  RoadTrip
//
//  Created by Chanmin Park on 12/1/20.
//

import Foundation
import Firebase

class CreateAccountVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    let db = Firestore.firestore()
    
    lazy var accountsRef = db.collection("accounts")
    
    @IBOutlet weak var usernameInput: UITextField!
    
    @IBOutlet weak var passwordInput: UITextField!
    
    @IBOutlet weak var confirmPasswordInput: UITextField!
    
    @IBAction func createAccount(_ sender: Any) {
        if usernameInput.text == "" {
            showErrorMessage(errorMsg: "Please write in a username")
            return
        }
        if passwordInput.text == "" {
            showErrorMessage(errorMsg: "Please write in a password")
            return
        }
        
        if confirmPasswordInput.text == "" {
            showErrorMessage(errorMsg: "Please confirm your password")
            return
        }
        
        if passwordInput.text != confirmPasswordInput.text {
            showErrorMessage(errorMsg: "Passwords do not match")
            return
        }
        
        let containsUsername = accountsRef.whereField("username", isEqualTo: usernameInput.text!)
        
        containsUsername.getDocuments() { (query, err) in
            if let err = err {
                print("Error checking for username: \(err)")
            } else {
                if query!.documents.isEmpty {
                    self.accountsRef.addDocument(
                        data: ["username" : self.usernameInput.text!,
                               "password": self.passwordInput.text!,
                               "isConnected": false])
                    self.showSuccessMessage()
                } else {
                    self.showErrorMessage(errorMsg: "Username is taken. Try a different one")
                }
            }
        }
    }
    
    func showSuccessMessage() {
        let alert = UIAlertController(title: "Account Created!", message: "Login to start!", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: backToLogIn))
        self.present(alert, animated: true)
    }
    
    func backToLogIn(action: UIAlertAction) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func showErrorMessage(errorMsg: String) {
        let alert = UIAlertController(title: "Try Again!", message: errorMsg, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
}

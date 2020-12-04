//
//  ViewController.swift
//  RoadTrip
//
//  Created by Chanmin Park on 11/27/20.
//

import UIKit
import Firebase

//protocol ConnectToSpotifyDelegate: class {
//    func connect()
//}

class LogInViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("hi")
    }
    
    let db = Firestore.firestore()
    lazy var accountsRef = db.collection("accounts")
    
    @IBOutlet weak var usernameInput: UITextField!
    
    @IBOutlet weak var passwordInput: UITextField!
    
    @IBAction func loginButton(_ sender: Any) {
        let containsUsername = accountsRef.whereField("username", isEqualTo: usernameInput.text!)
        
        containsUsername.getDocuments() { (query, err) in
            if let err = err {
                print("Error checking for username: \(err)")
            } else {
                if query!.documents.isEmpty {
                    self.showErrorMessage(errorMsg: "Username does not exist")
                } else {
                    if self.passwordInput.text != query!.documents[0].get("password") as? String {
                        self.showErrorMessage(errorMsg: "Wrong password")
                    } else {
                        self.successfulLogin()
                    }
                    
                }
            }
        }
    }
    
    func successfulLogin() {
        
        let currentAccount = accountsRef.whereField("username", isEqualTo: usernameInput.text!)
        currentAccount.getDocuments() { (query, err) in
            if let err = err {
                print("Error checking for username: \(err)")
            } else {
                let isConnected = query!.documents[0].get("isConnected") as? Bool
                if isConnected! {
                    self.performSegue(withIdentifier: "connectAsMember", sender: self)
                } else {
                    self.showMusicOptions()
                }
            }
        }
    }
    
    func showMusicOptions() {
        let alert = UIAlertController(title: "No music account has yet been linked to this account. Would you like to connect yours?", message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes! Connect to Spotify", style: .default, handler: connectToSpotify))
        alert.addAction(UIAlertAction(title: "Yes! Connect to Apple Music", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Nahh someone else will", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    
    
    func connectToSpotify(action: UIAlertAction) {
        let scope: SPTScope = [.appRemoteControl]
        
        if #available(iOS 11, *) {
            // Use this on iOS 11 and above to take advantage of SFAuthenticationSession
            sharedSpotifyHandler.sessionManager.initiateSession(with: scope, options: .clientOnly)
        } else {
            // Use this on iOS versions < 11 to use SFSafariViewController
            sharedSpotifyHandler.sessionManager.initiateSession(with: scope, options: .clientOnly, presenting: self)
        }
        
        let currAccount = accountsRef.whereField("username", isEqualTo: usernameInput.text!)
        
        currAccount.getDocuments() { (query, err) in
            if let err = err {
                print("Error checking for username: \(err)")
            } else {
                let id = query!.documents[0].documentID
                self.accountsRef.document(id).updateData([
                    "isConnected": true
                ])
            }
        }
        
        self.performSegue(withIdentifier: "connectAsMusicPlayer", sender: self)
        
    }
    
    func showErrorMessage(errorMsg: String) {
        let alert = UIAlertController(title: "Try Again!", message: errorMsg, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let currAccount = accountsRef.whereField("username", isEqualTo: usernameInput.text!)
        
        if segue.identifier == "connectAsMusicPlayer" {
            let vc = segue.destination as! CreateNameVC
            //vc.accessToken = sessionManager.session!.accessToken
            //print(accessToken)
            currAccount.getDocuments() { (query, err) in
                if let err = err {
                    print("Error checking for username: \(err)")
                } else {
                    vc.carAccountID = query!.documents[0].documentID
                }
            }
            vc.isMusicPlayer = true
        }
        if segue.identifier == "connectAsMember" {
            let vc = segue.destination as! CreateNameVC
            currAccount.getDocuments() { (query, err) in
                if let err = err {
                    print("Error checking for username: \(err)")
                } else {
                    vc.carAccountID = query!.documents[0].documentID
                }
            }
            
            vc.isMusicPlayer = false
        }

    }
    
    
}


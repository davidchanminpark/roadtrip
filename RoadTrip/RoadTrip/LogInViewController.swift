//
//  ViewController.swift
//  RoadTrip
//
//  Created by Chanmin Park on 11/27/20.
//

import UIKit
import Firebase

class LogInViewController: UIViewController  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        self.dismiss(animated: true, completion: nil)
        self.performSegue(withIdentifier: "connectToSpotify", sender: self)
    }
    
    func backToLogin(action: UIAlertAction) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func showErrorMessage(errorMsg: String) {
        let alert = UIAlertController(title: "Try Again!", message: errorMsg, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "connectToSpotify" {
            let vc = segue.destination as! ConnectSpotifyVC
            vc.username = usernameInput.text!
        }
        if segue.identifier == "connectAsMember"{
            let vc = segue.destination as! CreateNameVC
            vc.modalPresentationStyle = .fullScreen
            vc.username = usernameInput.text!
        }
    }
    
    //    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//      let parameters = appRemote.authorizationParameters(from: url);
//
//            if let access_token = parameters?[SPTAppRemoteAccessTokenKey] {
//                appRemote.connectionParameters.accessToken = access_token
//                self.accessToken = access_token
//            } else if let error_description = parameters?[SPTAppRemoteErrorDescriptionKey] {
//                // Show the error
//            }
//      return true
//    }
    
    
}


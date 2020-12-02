//
//  ViewController.swift
//  RoadTrip
//
//  Created by Chanmin Park on 11/27/20.
//

import UIKit

class LogInViewController: UIViewController, SPTSessionManagerDelegate, SPTAppRemoteDelegate {
    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        print("")
    }
    
    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
        print("")

    }
    
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        print("")

    }
    
    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        print("")

    }
    
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        print("")

    }
    

    lazy var configuration = SPTConfiguration(clientID: Auth.clientID, redirectURL: Auth.redirectURI)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    var accessToken = ""
    
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


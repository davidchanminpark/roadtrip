//
//  SpotifyHandler.swift
//  RoadTrip
//
//  Created by Chanmin Park on 12/4/20.
//

import Foundation
import Firebase

let sharedSpotifyHandler = SpotifyHandler()

class SpotifyHandler: NSObject, SPTAppRemoteDelegate, SPTSessionManagerDelegate {
    
    var config: SPTConfiguration = SPTConfiguration(clientID: Auth.clientID, redirectURL: Auth.redirectURI)
    
    lazy var appRemote: SPTAppRemote = {
        let appRemote = SPTAppRemote(configuration: config, logLevel: .debug)
        appRemote.delegate = self
        return appRemote
    }()
    
    lazy var sessionManager: SPTSessionManager = {
        if let tokenSwapURL = URL(string: "https://spotify-token-swap-roadtrip.herokuapp.com/api/token"),
           let tokenRefreshURL = URL(string: "https://spotify-token-swap-roadtrip.herokuapp.com/api/refresh_token") {
            config.tokenSwapURL = tokenSwapURL
            config.tokenRefreshURL = tokenRefreshURL
            }
        let manager = SPTSessionManager(configuration: config, delegate: self)
        return manager
    }()
    
    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        appRemote.connectionParameters.accessToken = session.accessToken
        //print("sessionmanager: \(session.accessToken)")
        //print("success: \(session.accessToken)")
        appRemote.connect()
        //let db = Firestore.firestore()
        print("sessionManager created")
    }
    
    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
        print("session failed")
    }
    
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        print("app remote connected")
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        print("app remote failed")
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        print("app remote disconnected")
    }
}

//
//  AppDelegate.swift
//  RoadTrip
//
//  Created by Chanmin Park on 11/27/20.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
//    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
//        self.appRemote.connectionParameters.accessToken = session.accessToken
//        self.appRemote.connect()
//    }
//
//    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
//        <#code#>
//    }
//
    
    //var auth = SPTAuth()
//    var accessToken = ""
    
    //var window: UIWindow?
    
//    lazy var configuration = SPTConfiguration(clientID: Auth.clientID, redirectURL: Auth.redirectURI)
    
//    lazy var sessionManager: SPTSessionManager = {
//            if let tokenSwapURL = URL(string: "https://[your token swap app domain here]/api/token"),
//               let tokenRefreshURL = URL(string: "https://[your token swap app domain here]/api/refresh_token") {
//                self.configuration.tokenSwapURL = tokenSwapURL
//                self.configuration.tokenRefreshURL = tokenRefreshURL
//                self.configuration.playURI = ""
//            }
//            let manager = SPTSessionManager(configuration: self.configuration, delegate: self)
//            return manager
//        }()
    
//    lazy var appRemote: SPTAppRemote = {
//      let appRemote = SPTAppRemote(configuration: self.configuration, logLevel: .debug)
//      appRemote.connectionParameters.accessToken = self.accessToken
//      appRemote.delegate = self
//      return appRemote
//    }()
//
//
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//      let parameters = appRemote.authorizationParameters(from: url);
//
//            if let access_token = parameters?[SPTAppRemoteAccessTokenKey] {
//                appRemote.connectionParameters.accessToken = access_token
//                self.accessToken = access_token
//            } else if let error_description = parameters?[SPTAppRemoteErrorDescriptionKey] {
//                // Show the error
//                print(error_description)
//            }
//      return true
//    }
    
//    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
//        print("connected")
//    }
//
//    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
//        print("disconnected")
//
//    }
//
//    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
//        print("failed")
//
//    }
//
//    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
//        print("player state changed")
//
//    }
    
    


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        return true
    }
    
//    func setup() {
//        SPTAuth.defaultInstance().clientID = Auth.clientID
//        SPTAuth.defaultInstance().redirectURL = Auth.redirectURI
//        SPTAuth.defaultInstance().sessionUserDefaultsKey = Auth.sessionKey
//
//        //For this application we just want to stream music, so we will only request the streaming scope
//        SPTAuth.defaultInstance().requestedScopes = [SPTAuthStreamingScope]
//
//        // Start the player (this is only need for applications that using streaming, which we will use
//        // in this tutorial)
//        do {
//            try SPTAudioStreamingController.sharedInstance().start(withClientId: Constants.clientID)
//        } catch {
//            fatalError("Couldn't start Spotify SDK")
//        }
//
//    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


//
//  AppDelegate.swift
//  RoadTrip
//
//  Created by Chanmin Park on 11/27/20.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    override init() {
        FirebaseApp.configure()
    }
    
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    lazy var loginVC = storyBoard.instantiateViewController(withIdentifier: "loginVC") as! LogInViewController
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        print("openurl")
        sharedSpotifyHandler.sessionManager.application(app, open: url, options: options)
        return true
    }
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
 //       window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = loginVC
//        window?.makeKeyAndVisible()
        
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
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

//    @available(iOS 13.0, *)
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }

//    @available(iOS 13.0, *)
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }


}


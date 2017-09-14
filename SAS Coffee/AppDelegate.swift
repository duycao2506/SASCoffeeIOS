//
//  AppDelegate.swift
//  SAS Coffee
//
//  Created by Duy Cao on 8/30/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Google
import RealmSwift
import NVActivityIndicatorView

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UIApplication.shared.statusBarStyle = .lightContent
        LangUtil.switchLang(code: LangCode.EN)
        configLoadingBlocker()
        
        GMSServices.provideAPIKey(GlobalUtils.GG_API_MAP_KEY)
        GMSPlacesClient.provideAPIKey(GlobalUtils.GG_API_MAP_KEY)
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        //gid
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(String(describing: configureError))")
        
        GIDSignIn.sharedInstance().clientID = GlobalUtils.GG_IOS_CLIENT_ID
        GIDSignIn.sharedInstance().serverClientID = GlobalUtils.GG_SERVER_CLIENT_ID
        RealmWrapper.config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
            // potentially lengthy data migration
        })
        RealmWrapper.realm = try! Realm.init(configuration: RealmWrapper.config)
        
        return true
    }

    
    func configLoadingBlocker(){
        NVActivityIndicatorView.DEFAULT_TYPE = .ballPulse
        NVActivityIndicatorView.DEFAULT_BLOCKER_MESSAGE = "loading".localize()
        NVActivityIndicatorView.DEFAULT_PADDING = 10.0
        NVActivityIndicatorView.DEFAULT_COLOR = Style.colorSecondary
        NVActivityIndicatorView.DEFAULT_BLOCKER_SIZE = CGSize(width: 100, height: 50)
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        GIDSignIn.sharedInstance().signOut()
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        let FBhanlde = FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
        print("FB" + sourceApplication!)
        
        let GGHandle = GIDSignIn.sharedInstance().handle(url as URL!,
                                                         sourceApplication: sourceApplication,
                                                         annotation: annotation)
        
        return FBhanlde || GGHandle
    }

    private func application(application: UIApplication,
                     openURL url: URL, options: [String: AnyObject]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url as URL!,
                                                    sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication.rawValue] as? String,
                                                    annotation: options[UIApplicationOpenURLOptionsKey.annotation.rawValue])
    }
    
    

}


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
import Firebase
import FirebaseMessaging
import GoogleSignIn
import RealmSwift
import NVActivityIndicatorView
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate
{

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UIApplication.shared.statusBarStyle = .lightContent
        LangUtil.switchLang(code: LangCode.EN)
        configLoadingBlocker()
        
        
        
        GMSServices.provideAPIKey(AppSetting.sharedInstance().GG_API_MAP_KEY)
        GMSPlacesClient.provideAPIKey(AppSetting.sharedInstance().GG_API_MAP_KEY)
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        //gid
        FirebaseApp.configure()
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().serverClientID = AppSetting.sharedInstance().GG_SERVER_CLIENT_ID
        RealmWrapper.config = Realm.Configuration(
            schemaVersion: 3,
            migrationBlock: { migration, oldSchemaVersion in
            // potentially lengthy data migration
        })
        RealmWrapper.realm = try! Realm.init(configuration: RealmWrapper.config)
        
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.badge, .alert, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        Messaging.messaging().delegate = self
        Messaging.messaging().shouldEstablishDirectChannel = true
        
        let token = Messaging.messaging().fcmToken
        print("FCM token: \(token ?? "")")
        
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
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        let FBhanlde = FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
        print("FB" + sourceApplication!)
        
        let GGHandle = GIDSignIn.sharedInstance().handle(url,
                                                        sourceApplication: sourceApplication,
                                                        annotation: annotation)
        return FBhanlde || GGHandle
    }

    private func application(application: UIApplication,
                     openURL url: URL, options: [String: AnyObject]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication.rawValue] as? String,
                                                 annotation: [:])
    }
    
    //
    // Firebase
    //
    
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
    }
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
//        if #available(iOS 10.0, *) {
//            //iOS 10 or above version
//            let center = UNUserNotificationCenter.current()
//            let content = UNMutableNotificationContent()
//            content.title = "Late wake up call"
//            content.body = "The early bird catches the worm, but the second mouse gets the cheese."
//            content.categoryIdentifier = "alarm"
//            content.userInfo = ["customData": "fizzbuzz"]
//            content.sound = UNNotificationSound.default()
//
//            let day = Date.init()
//            var dateComponents = Calendar.current.dateComponents([.hour, .minute], from: Calendar.current.date(byAdding: .second, value: 30, to: day)!)
//            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//
//            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//            center.add(request)
//        } else {
//            // ios 9
//            let notification = UILocalNotification()
//            notification.fireDate = NSDate(timeIntervalSinceNow: 5) as Date
//            notification.alertBody = "Hey you! Yeah you! Swipe to unlock!"
//            notification.alertAction = "be awesome!"
//            notification.soundName = UILocalNotificationDefaultSoundName
//            UIApplication.shared.scheduleLocalNotification(notification)
//
//            let notification1 = UILocalNotification()
//            notification1.fireDate = NSDate(timeIntervalSinceNow: 15) as Date
//            notification1.alertBody = "Hey you! Yeah you! Swipe to unlock!"
//            notification1.alertAction = "be awesome!"
//            notification1.soundName = UILocalNotificationDefaultSoundName
//            UIApplication.shared.scheduleLocalNotification(notification1)
//        }
        
        print(remoteMessage)
        print("dsadasdsa")
    }
    
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print(userInfo)
        print("Hello")
        NotificationCenter.default.post(Notification.init(name: .init(EventConst.REMOTE_NOTI), object: nil, userInfo: userInfo))
        completionHandler(UIBackgroundFetchResult.newData)
    }
   
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        print(userInfo)
    }
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    

}


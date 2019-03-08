//
//  AppDelegate.swift
//  Learn Cab
//
//  Created by Exarcplus on 24/11/17.
//  Copyright © 2017 Exarcplus. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import AFNetworking
import AVFoundation
import Firebase
import FirebaseInstanceID
import FirebaseMessaging
import UserNotifications


var newDeviceId = ""

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate, MessagingDelegate {
    
    var window: UIWindow?
    var myclass:MyClass!
    
      let gcmMessageIDKey = "gcm.message_id"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager .sharedManager().enable = true
        IQKeyboardManager .sharedManager().shouldResignOnTouchOutside = true
        IQKeyboardManager .sharedManager().enableAutoToolbar = false
        AFNetworkReachabilityManager.shared().startMonitoring()
        
        application.setStatusBarStyle(UIStatusBarStyle.lightContent, animated: true)
        UIApplication.shared.statusBarStyle = .lightContent
        //        UIApplication.shared.setStatusBarHidden(false, with: .fade)
                UINavigationBar.appearance().barTintColor = UIColor(red: 18/255, green: 98/255, blue: 151/255, alpha: 1)
               UINavigationBar.appearance().tintColor = UIColor.white
        //        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white,NSAttributedStringKey.font: UIFont(name: "Poppins-Medium", size: 16)!]
        //        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "Poppins-Medium", size: 16)!],for: UIControlState())
        //        UIBarButtonItem.appearance()
        //            .setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.white],
        //                                    for: UIControlState.disabled)
        
        //        var colors = [UIColor]()
        //        colors.append(UIColor(red: 18/255, green: 98/255, blue: 151/255, alpha: 1))
        //        colors.append(UIColor(red: 28/255, green: 154/255, blue: 96/255, alpha: 1))
        //        U
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: 0, vertical: -60), for:UIBarMetrics.default)
        UINavigationBar.appearance().isTranslucent = false
        
//        FirebaseApp.configure()
//        Messaging.messaging().delegate = self
//
//        if #available(iOS 10.0, *) {
//            // For iOS 10 display notification (sent via APNS)
//            UNUserNotificationCenter.current().delegate = self
//            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
//            UNUserNotificationCenter.current().requestAuthorization(
//                options: authOptions,
//                completionHandler: {_, _ in })
//            // For iOS 10 data message (sent via FCM
//
//        } else {
//            let settings: UIUserNotificationSettings =
//                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
//            application.registerUserNotificationSettings(settings)
//        }
        
        
        var success: Bool
        do
        {
            if #available(iOS 10.0, *) {
                try? AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient, mode: .default, options: [])
            } else {
                // Fallback on earlier versions
            }
            success = true
        }
        catch let error as NSError
        {
            success = false
        }
        
        setupSiren()
        // Override point for customization after application launch.
        return true
    }
    
    var orientationLock = UIInterfaceOrientationMask.portrait
    var myOrientation: UIInterfaceOrientationMask = .portrait
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return myOrientation
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
       
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
       
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
       
        Siren.shared.checkVersion(checkType: .immediately)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
      
        Siren.shared.checkVersion(checkType: .daily)
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
       
    }
    
    func setupSiren() {
        let siren = Siren.shared
        
        // Optional
        siren.delegate = self
        
        // Optional
        siren.debugEnabled = true
     
        siren.majorUpdateAlertType = .option
        siren.minorUpdateAlertType = .option
        siren.patchUpdateAlertType = .option
        siren.revisionUpdateAlertType = .option
        
      
    }
//    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any])
//    {
//        if let messageID = userInfo[gcmMessageIDKey]
//        {
//            print("Message ID: \(messageID)")
//        }
//
//        //let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        //appDelegate.SideMenu.hideRightView(animated: true, completionHandler: nil)
//        //UIApplication.shared.unregisterForRemoteNotifications()
//        // Print full message.
//        print(userInfo)
//    }
//
//    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
//                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void)
//    {
//        if let messageID = userInfo[gcmMessageIDKey] {
//            print("Message ID: \(messageID)")
//            UserDefaults.standard.set(userInfo, forKey:"type")
//            UserDefaults.standard.synchronize()
//            //messageType = messageID
//        }
//        completionHandler(UIBackgroundFetchResult.newData)
//    }
//    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
//        // Let FCM know about the message for analytics etc.
//        Messaging.messaging().appDidReceiveMessage(userInfo)
//        // handle your message
//    }
//
//    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data)
//    {
//
//        if let refreshedToken = InstanceID.instanceID().token()
//        {
//            print("InstanceID token: \(refreshedToken)")
//            newDeviceId = refreshedToken
//            print(newDeviceId)
//            //default.set(refreshedToken, forKey: Constant.UserDefaults.token)
//
//            Messaging.messaging().apnsToken = deviceToken
//
//            print("Token generated: ", refreshedToken)
//        }
//        UserDefaults.standard.set(newDeviceId, forKey:"device_token")
//        UserDefaults.standard.synchronize()
//        let devicetoken : String!
//        devicetoken = UserDefaults.standard.string(forKey:"device_token") as String?
//        print(devicetoken)
//        connectToFcm()
//    }
//    func connectToFcm() {
//        //Messaging.messaging().shouldEstablishDirectChannel = true
//        fcmConnectionStateChange()
//    }
//
//    func fcmConnectionStateChange() {
//        if Messaging.messaging().isDirectChannelEstablished {
//            print("Connected to FCM.")
//        } else {
//            print("Disconnected from FCM.")
//        }
//    }
//
//    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
//        print("Firebase registration token: \(fcmToken)")
//        print(fcmToken)
//
//        UserDefaults.standard.set(fcmToken, forKey:"device_token")
//        UserDefaults.standard.synchronize()
//        let devicetoken : String!
//        devicetoken = UserDefaults.standard.string(forKey:"device_token") as String?
//        print(devicetoken)
//
//        // TODO: If necessary send token to application server.
//        // Note: This callback is fired at each app startup and whenever a new token is generated.
//    }
//    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
//        print("Received data message: \(remoteMessage.appData)")
//
//        //        let msgType : String!
//        //        msgType = remoteMessage.appData[AnyHashable("type")] as! String
//        //        print(msgType)
//
//    }
//
//    @available(iOS 10.0, *)
//    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        let content = notification.request.content
//        print("\(content.userInfo)")
//        completionHandler([.alert, .sound])
//        print("GOT A NOTIFICATION")
//    }
    
    
}
extension AppDelegate: SirenDelegate
{
    func sirenDidShowUpdateDialog(alertType: Siren.AlertType) {
        print(#function, alertType)
    }
    
    func sirenUserDidCancel() {
        print(#function)
    }
    
    func sirenUserDidSkipVersion() {
        print(#function)
    }
    
    func sirenUserDidLaunchAppStore() {
        print(#function)
    }
    
    func sirenDidFailVersionCheck(error: NSError) {
        print(#function, error)
    }
    
    func sirenLatestVersionInstalled() {
        print(#function, "Latest version of app is installed")
    }
    
    // This delegate method is only hit when alertType is initialized to .none
    func sirenDidDetectNewVersionWithoutAlert(message: String) {
        print(#function, "\(message)")
    }
}




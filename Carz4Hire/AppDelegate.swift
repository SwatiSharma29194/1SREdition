//
//  AppDelegate.swift
//  Carz4Hire
//
//  Created by user on 3/1/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import UserNotifications
import GooglePlaces
import GoogleMaps
import Firebase
import FirebaseInstanceID
import Stripe
import BraintreeDropIn
import Braintree
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,MessagingDelegate,UNUserNotificationCenterDelegate {

    var window: UIWindow?
var userData = UserDefaults()
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        
    }
    
    let kGCMMessageIDKey = "gcm.message_id"
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
     STPPaymentConfiguration.shared().publishableKey = "pk_test_6XeEDwEBDmQCDG1RvWYpTBDn"
//        BTAppSwitch.returnURLScheme = "com.your-company.Your-App.payments"
       // BTAppSwitch.returnURLScheme = "com.rvtech.1SR.payments"
        BTAppSwitch.setReturnURLScheme("com.rvtech.1SR.payments")
      // STPPaymentConfiguration.shared().publishableKey = "pk_live_3QMmFIh8I3TImS1my0ko43rU"
        
        // do any other necessary launch configuration
        GMSPlacesClient.provideAPIKey("AIzaSyDlrQ6AvB59AnKN14GHJ0Vs88qU9_4--BA")
        GMSServices.provideAPIKey("AIzaSyDlrQ6AvB59AnKN14GHJ0Vs88qU9_4--BA")
     //AIzaSyBIscXnlg5TC6noyOPuC1LhkS9kZr6gtz -_MI
        
        if(!(userData.value(forKey: "emailSave") == nil))
        {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let otherVC = sb.instantiateViewController(withIdentifier: "navigationBooking") as! UINavigationController
      
            window?.rootViewController = otherVC;
        }
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) {(accepted, error) in
                if !accepted {
                    print("Notification access denied.")
                }
            }
        } else {
            // Fallback on earlier versions
        }
        
        
        // Override point for customization after application launch.
        //        GMSServices.provideAPIKey("AIzaSyACcgLgGUIRBuL-p6J-ho8XieyRuNLKaCg")
        //        GMSPlacesClient.provideAPIKey("AIzaSyACcgLgGUIRBuL-p6J-ho8XieyRuNLKaCg")
        
        
        if #available(iOS 10.0, *) {
            
            let center = UNUserNotificationCenter.current()
            
            center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
                
            }
            
        }
        Thread.sleep(forTimeInterval: 3.0)
        
        
        UserDefaults.standard.removeObject(forKey: "login")
        //        FirebaseApp.configure()
        //
        Messaging.messaging().delegate = self
        
        
        if #available(iOS 10.0, *) // enable new way for notifications on iOS 10
        {
            let center = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options: [.badge, .alert , .sound]) { (accepted, error) in
                if !accepted
                {
                    print("Notification access denied.")
                }
                else
                {
                    print("Notification access accepted.")
                    UIApplication.shared.registerForRemoteNotifications();
                }
            }
        }
        else
        {
            let type: UIUserNotificationType = [UIUserNotificationType.badge, UIUserNotificationType.alert, UIUserNotificationType.sound];
            let setting = UIUserNotificationSettings(types: type, categories: nil);
            UIApplication.shared.registerUserNotificationSettings(setting);
            UIApplication.shared.registerForRemoteNotifications();
        }
        //-------------------------------------------------------------------------//
        
        application.registerForRemoteNotifications()
        
//        Messaging.messaging().remoteMessageDelegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(self.tokenRefreshNotification),
                                               name: NSNotification.Name.InstanceIDTokenRefresh, object: nil)
        FirebaseApp.configure()
//        Messaging.messaging().shouldEstablishDirectChannel = true
        

//
   
        // Override point for customization after application launch.
        return true
        
    }
    @objc func tokenRefreshNotification(notification: NSNotification) {
        
        if let refreshedToken = InstanceID.instanceID().token() {
            
            userData.set(InstanceID.instanceID().token() as Any, forKey: "tokenn")
            
            print("InstanceID token: \(refreshedToken)")
            
        }
        
        // Connect to FCM since connection may have failed when attempted before having a token.
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data)
    {
        debugPrint("didRegisterForRemoteNotificationsWithDeviceToken: DATA")
        let token = String(format: "%@", deviceToken as CVarArg)
        debugPrint("*** deviceToken: \(token)")
        Messaging.messaging().apnsToken = deviceToken
        debugPrint("Firebase Token:",InstanceID.instanceID().token() as Any)
        
        if(!(InstanceID.instanceID().token() == nil))
            
        {
            userData.set(InstanceID.instanceID().token() as Any, forKey: "tokenn")
        }
    }
    
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        
        var userInfo = notification.request.content.userInfo
        
        if (userInfo[kGCMMessageIDKey] != nil) {
            print("Message ID: \(String(describing: userInfo[kGCMMessageIDKey]))")
        }
        NotificationCenter.default.addObserver(self, selector: #selector(self.tokenRefreshNotification), name: NSNotification.Name.InstanceIDTokenRefresh, object: nil)
        // Print full message.
        print("\(userInfo)")
        // Change this to your preferred presentation option
        completionHandler([.sound, .alert, .badge])
        print("User Info : \(notification.request.content.userInfo)")
     
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        print("Received direct channel message:)",userInfo)
        
        
    
    }
    //    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
    //
    //          print("Received direct channel message:\n")
    //    }
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage)
    {
        //        let sb = UIStoryboard(name: "Main", bundle: nil)
        //
        //
        //        let otherVC = sb.instantiateViewController(withIdentifier: "chat") as! chatViewController
        //
        //        //
        //        window?.rootViewController = otherVC;
        
        
        debugPrint("--->messaging:\(messaging)")
        debugPrint("--->didReceive Remote Message:\(remoteMessage.appData)")
        guard let data =
            try? JSONSerialization.data(withJSONObject: remoteMessage.appData, options: .prettyPrinted),
            let prettyPrinted = String(data: data, encoding: .utf8) else { return }
        print("Received direct channel message:\n\(prettyPrinted)")
        0
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


}


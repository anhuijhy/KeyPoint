//
//  AppDelegate.swift
//  KeyPoint
//
//  Created by 123 on 2018/3/29.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let vc = ViewController()
        let nav = UINavigationController.init(rootViewController: vc)
      
        let config = Realm.Configuration(fileURL: URL(fileURLWithPath: RLMRealmPathForFile("default.realm")), inMemoryIdentifier: nil, syncConfiguration: nil, encryptionKey: nil, readOnly: false, schemaVersion: 5, migrationBlock: { (migration, v) in
            print("migration")
            //之前是1
            migration.enumerateObjects(ofType: Dog.className(), { (oldObj, newObj) in

            })
            
            
        }, deleteRealmIfMigrationNeeded: false, shouldCompactOnLaunch: { (a, b) -> Bool in
            return true
        }, objectTypes: nil)
        
        Realm.Configuration.defaultConfiguration = config
        Realm.asyncOpen { (real, err) in
            
            if let _ = real{
                
                print("Realm 数据库配置成功")
                
            }else{
                print("the realm error \(String(describing: err))")
            }
        }
        
        RCIM.shared().enableMessageAttachUserInfo = true
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        self.registerRongClound()
        self.connectionRCIM()
        
        let c = UNUserNotificationCenter.current()
        c.requestAuthorization(options: [.badge,.alert,.sound]) { (b, e) in
            
            print("regis \(b) e\(String(describing: e))")
        }
        
        return true
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

extension AppDelegate{
    
    func registerRongClound() -> Void {
        
        RCIM.shared().initWithAppKey("8brlm7uf8zxc3")
        
    }
    
    func connectionRCIM() -> Void {
        
        RCIM.shared().connect(withToken: "n/DcoIpcOH3D08o5dP91mKpkfEB8Yk/wtBvLtAPd1GP52lBk7EXdqBc6AW8obNSuSZq6IYgwh4dJah+76w7M1Q==", success: { (str) in

        }, error: { (err) in
            print("connnect err")
        }) {
            print("connnect incorrect")
        }
        
        
//                RCIM.shared().connect(withToken: "WmJ8w0HA8UHWtBUwgxwkEZkaiBnOfVWS4c4ny9vGjX2DjBgdTx7/zPHzJSeZ/97cCJhCPhPGu/w=", success: { (str) in
//
//                    print("connection suc")
//
//                }, error: { (err) in
//                    print("connnect err")
//                }) {
//                    print("connnect incorrect")
//                }
        
        RCIM.shared().receiveMessageDelegate = self
        
        RCIM.shared().userInfoDataSource = RCHelper.helper
        
        RCIM.shared().enablePersistentUserInfoCache = true
        

 
        
    }
}


extension AppDelegate:RCIMReceiveMessageDelegate{
    
    func onRCIMReceive(_ message: RCMessage!, left: Int32) {
        
//        print("i have recived msg\(message.messageId) left =\(left) userinfo=\(message.content.senderUserInfo.name) \(message.content.senderUserInfo.userId) \(message.content.senderUserInfo.portraitUri) and revice status =\(message.receivedStatus.rawValue)")
        
        print("the msg object name is \(message.objectName)")
        let unReadCount = RCIMClient.shared().getTotalUnreadCount()
        print("unread count is\(unReadCount)")
    }
    
    func onRCIMCustomLocalNotification(_ message: RCMessage!, withSenderName senderName: String!) -> Bool {
        
        return false
    }
}


extension AppDelegate:UNUserNotificationCenterDelegate{
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        //应用内显示
        
        print("应用内显示")
    }
    
}


//
//  AppDelegate.swift
//  UserAcquisition
//
//  Created by 坂本貴宏 on 2017/11/13.
//  Copyright © 2017年 坂本貴宏. All rights reserved.
//

import UIKit
import NCMB
import UserNotifications
import FBSDKCoreKit
import FBSDKLoginKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
         NCMB.setApplicationKey("873f0235ee99fffc1f3e35bd7a9b664efc9a8433cf87ec8de8c63bc9fe1342e8",clientKey: "c9ad94e5a25b4ef0deafaffc969db813b06abdc1be3a53975c1a0b2a260dff64")
        
        // デバイストークンの要求
        if #available(iOS 11.0, *){
            /** iOS10以上 **/
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert, .badge, .sound]) {granted, error in
                if error != nil {
                    // エラー時の処理
                    return
                }
                if granted {
                    DispatchQueue.main.async(execute: {
                        // デバイストークンの要求
                        UIApplication.shared.registerForRemoteNotifications()
                    })
                    
                }
            }
        } else {
            /** iOS8以上iOS10未満 **/
            //通知のタイプを設定したsettingを用意
            let setting = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            //通知のタイプを設定
            application.registerUserNotificationSettings(setting)
            //DevoceTokenを要求
            DispatchQueue.main.async(execute: {
                // デバイストークンの要求
                UIApplication.shared.registerForRemoteNotifications()
            })
        }
        
        
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    // デバイストークンが取得されたら呼び出されるメソッド
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data){
        // 端末情報を扱うNCMBInstallationのインスタンスを作成
        let installation = NCMBInstallation.current()
        // デバイストークンの設定
        installation?.setDeviceTokenFrom(deviceToken)
        // 端末情報をデータストアに登録
        installation?.saveInBackground({ (error) in
            if error != nil {
                // 端末情報の登録に失敗した時の処理
                let err = error as! NSError
                if (err.code == 409001){
                    // 失敗した原因がデバイストークンの重複だった場合
                    // 端末情報を上書き保存する
                    self.updateExistInstallation(currentInstallation: installation!)
                }else{
                    // デバイストークンの重複以外のエラーが返ってきた場合
                }
            } else {
                // 端末情報の登録に成功した時の処理
            }
        })
    }
    
    // 端末情報を上書き保存するupdateExistInstallationメソッドを用意
    func updateExistInstallation(currentInstallation : NCMBInstallation){
        let installationQuery = NCMBInstallation.query()
        installationQuery?.whereKey("deviceToken", equalTo:currentInstallation.deviceToken)
        do {
            let searchDevice = try installationQuery?.getFirstObject() as! NCMBInstallation
            // 端末情報の検索に成功した場合
            // 上書き保存する
            currentInstallation.objectId = searchDevice.objectId
            currentInstallation.saveInBackground({ (error) in
                if (error != nil){
                    // 端末情報の登録に失敗した時の処理
                }else{
                    // 端末情報の登録に成功した時の処理
                }
            })
        } catch let searchErr as NSError {
            // 端末情報の検索に失敗した場合の処理
        }
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
        FBSDKAppEvents.activateApp()
    }
    
//    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String!,annotation: Any) -> Bool {
//        print(sourceApplication)
//
//        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url as URL! , sourceApplication: sourceApplication, annotation: annotation)
//    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let sourceApplication: String? = options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String
        print(sourceApplication!)
        print("OKOKOOKOKKOK")
        return FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: sourceApplication, annotation: nil)

    }

    
//    func applicationsourceapplic

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


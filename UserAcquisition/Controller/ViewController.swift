//
//  ViewController.swift
//  UserAcquisition
//
//  Created by 坂本貴宏 on 2017/11/13.
//  Copyright © 2017年 坂本貴宏. All rights reserved.
//

import UIKit
import NCMB
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("User Logged In")
        
                if ((error) != nil)
                {
                    //エラー処理
                    print("エラー")
                } else if result.isCancelled {
                    //キャンセルされた時
                    print("キャンセル")
                } else {
                    print("情報を保存")
                    //必要な情報が取れていることを確認(今回はemail必須)
                    if result.grantedPermissions.contains("public_profile")
                    {
                        print("成功")
                        var facebookInfo : [AnyHashable: Any] = [
                            "id" : result.token.userID,
                            "access_token" : result.token.tokenString,
                            "expiration_date" : result.token.expirationDate
                        ]

                        let userToFacebook = NCMBUser()
                        userToFacebook.signUp(withFacebookToken: facebookInfo) { (error) in
                            if ((error) != nil){
                                //会員登録に失敗した場合の処理
                                print("失敗")
                            } else {
                                //会員登録に成功した場合の処理
                                print("登録完了")
                                let insObjectId = NCMBInstallation.current().objectId
                                print(insObjectId)
                                let userObject = NCMBObject(className: "user")
                                userObject?.setObject(insObjectId, forKey: "insObjectId")
                                userObject?.saveInBackground({ (error) in
                                    if error == nil {
                                        print("プッシュ通知準備できたよーーー")
                                    } else {
                                        print("やり直してーーーーーーーーーー")
                                        print(error)
                                    }
                                })
                                userToFacebook.userName = "たかひろ"
                                print(userToFacebook.userName)
                            }
                        }
                        // 次の画面に遷移
                        self.performSegue(withIdentifier: "ShowUsers", sender: self)
                    } else {
                        
                    }
                }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
    //, FBSDKLoginButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (FBSDKAccessToken.current() != nil) {
            print("User Already Logged In")
            self.performSegue(withIdentifier: "ShowUsers", sender: self)
        } else {
            let loginButton = FBSDKLoginButton()
            loginButton.delegate = self
            loginButton.center = view.center
            loginButton.readPermissions = ["public_profile"]
            view.addSubview(loginButton)
        }
        
        print(NCMBInstallation.current().deviceToken)
    }
    @IBAction func clikedLoginButton(_ sender: UIButton) {
       
    }
//        let userToFacebook = NCMBUser()
//        userToFacebook.signUp(withFacebookToken: [AnyHashable : Any]!) { (error) in
//            if (error){
//                //会員登録に失敗した場合の処理
//            } else {
//                //会員登録に成功した場合の処理
//            }
//        }
//
    
        
//        NCMBFacebookUtils.logInWithReadPermission(["email"]) {(user, error) -> Void in
//            if (error != nil){
//                if (error.code == NCMBErrorFacebookLoginCancelled){
//                    // Facebookのログインがキャンセルされた場合
//                    print("キャンセル")
//                }else{
//                    // その他のエラーが発生した場合
//                    print("エラー")
//                }
//            }else{
//                // 会員登録後の処理
//                self.performSegue(withIdentifier: "ShowUsers", sender: self)
//            }
//        }
    
    
    //ログインボタンが押された時の処理。Facebookの認証とその結果を取得する
//    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
//        print("User Logged In")
//
//        if ((error) != nil)
//        {
//            //エラー処理
//            print("エラー")
//        } else if result.isCancelled {
//            //キャンセルされた時
//            print("キャンセル")
//        } else {
//            //必要な情報が取れていることを確認(今回はemail必須)
//            if result.grantedPermissions.contains("email")
//            {
//                print("成功")
//                // 次の画面に遷移
//                self.performSegue(withIdentifier: "ShowUsers", sender: self)
//            }
//        }
//    }
//
//
//    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
//        print("User Logged Out")
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


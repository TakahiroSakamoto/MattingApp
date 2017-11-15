//
//  User.swift
//  UserAcquisition
//
//  Created by 坂本貴宏 on 2017/11/13.
//  Copyright © 2017年 坂本貴宏. All rights reserved.
//

import UIKit
import NCMB

class User: NSObject {
    var name: String
    var password: String
    
    init(name: String, password: String) {
        self.name = name
        self.password = password
    }
    
    func signUp(callback: @escaping (_ message: String?) -> Void) {
        let user = NCMBUser()
        user.userName = name
        user.password = password
        
        
        user.signUpInBackground { (error) in
            callback(error?.localizedDescription)
        }
        
        //        var query: NCMBQuery? = NCMBUser.query()
        //        print(query?.ncmbClassName)
        //        query?.whereKeyExists("userName")
        
        
    }
}


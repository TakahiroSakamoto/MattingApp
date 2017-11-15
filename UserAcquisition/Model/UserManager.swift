//
//  UserManager.swift
//  UserAcquisition
//
//  Created by 坂本貴宏 on 2017/11/13.
//  Copyright © 2017年 坂本貴宏. All rights reserved.
//

import UIKit
import NCMB

class UserManager: NSObject {
    static let sharedInstance = UserManager()
    var users: [User] = []
    
    
    func fetchUsers(callback: @escaping () -> Void) {
        let query = NCMBQuery(className: "user")
        query?.order(byDescending: "updateDate")
        query?.findObjectsInBackground({ (objects, error) in
            if error == nil {
                self.users = []
                print(objects?.count)
                for object in objects! {
                    let member = (object as! NCMBObject).object(forKey: "userName") as! String
                    let user = User(name: member, password: "")
                    self.users.append(user)
                    callback()
                }
            }
        })
}
}

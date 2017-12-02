//
//  UsersTableViewController.swift
//  UserAcquisition
//
//  Created by 坂本貴宏 on 2017/11/13.
//  Copyright © 2017年 坂本貴宏. All rights reserved.
//

import UIKit
import NCMB

class UsersTableViewController: UITableViewController {

    let userManager = UserManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Cellの高さ
        tableView.estimatedRowHeight = 90
        
        // Cellが自動調整される
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let nib = UINib(nibName: "UsersTableViewCell", bundle: nil)
        
        self.tableView.register(nib, forCellReuseIdentifier: "UserTableViewCell")
        
        
        
        userManager.fetchUsers { () in
            self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return userManager.users.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UsersTableViewCell
        
        let user = userManager.users[indexPath.row]
        cell.userNameLabel.text! = user.name
       
        cell.LikeButton.addTarget(self, action: #selector(self.onClicked(_:
            )), for: UIControlEvents.touchUpInside)
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//
//        let user = userManager.users[indexPath.row]
//        self.userName.text! = user.name
//        cell.textLabel?.text = self.userName.text!

        return cell
    }
    
    // セルをクリックしたらそのユーザーのプロフィールに遷移
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = userManager.users[indexPath.row]
        
    }
    
    
    @objc func onClicked(_ sender: UIButton) {
        let cell = sender.superview?.superview as! UITableViewCell
        guard let row = self.tableView.indexPath(for: cell)?.row else {
            
            return
        }
        
        // セルに対応したユーザーを取得し、プッシュ通知の処理を記述する
        print("\(row)")
        
        // InstallationのObjectID取得
        print(NCMBInstallation.current().objectId)
        
        /* installation を指定して絞り込み */
        let query = NCMBInstallation.query()
        query?.whereKey("objectId", equalTo: userManager.users[row])
        
        var push = NCMBPush()
        push.setSearchCondition(query)
        
        let data_iOS = ["contentAvailable" : false, "badgeIncrementFlag" : true, "sound" : "default"] as [String : Any]
        push.setData(data_iOS)
        push.setPushToIOS(true)
        push.setTitle("-----Title-----")
        push.setMessage("-----Message-----")
        push.setImmediateDeliveryFlag(true) // 即時配信
        push.sendInBackground { (error) in
            if error != nil {
                // プッシュ通知登録に失敗した場合の処理
                print("NG:\(error)")
            } else {
                // プッシュ通知登録に成功した場合の処理
                print("OK")
            }
        }
        
        
//        // pushを打つ相手を指定するクエリ
//        let pushQuery = PFInstallation.query()
//        pushQuery.whereKey("user", equalTo: user)
//
//        // payload の中身を設定
//        let data = ["alert":"メッセージが届きました",
//                    "badge":1,
//                    "sound":"default",
//                    "type":"reaction"]
//
//        // push通知を生成
//        let push = PFPush()
//        push.setQuery(pushQuery)
//        push.setData(data)
//
//        // push通知を送信
//        push.sendPushInBackgroundWithBlock { (isSuccess, error) -> Void in
//            // 送信完了後の処理
//        }
    }
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}


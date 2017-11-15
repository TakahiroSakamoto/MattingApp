//
//  TabBarController.swift
//  UserAcquisition
//
//  Created by 坂本貴宏 on 2017/11/13.
//  Copyright © 2017年 坂本貴宏. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let blue = UIColor(red: 11.0/255, green: 78.0/255, blue: 160.0/255, alpha: 1.0)
        
        UITabBar.appearance().tintColor = blue
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

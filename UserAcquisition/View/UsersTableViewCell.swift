//
//  UsersTableViewCell.swift
//  UserAcquisition
//
//  Created by 坂本貴宏 on 2017/11/13.
//  Copyright © 2017年 坂本貴宏. All rights reserved.
//

import UIKit

class UsersTableViewCell: UITableViewCell {
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var LikeButton: UIButton!
    

    let userManager = UserManager.sharedInstance
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        LikeButton.layer.cornerRadius = LikeButton.frame.width/2
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

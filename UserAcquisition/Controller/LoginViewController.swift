//
//  LoginViewController.swift
//  UserAcquisition
//
//  Created by 坂本貴宏 on 2017/11/13.
//  Copyright © 2017年 坂本貴宏. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func OnLoginButton(_ sender: UIButton) {
        
    }
    
    @IBAction func OnSignUpButton(_ sender: UIButton) {
        let user = User(name: userNameTextField.text!, password: passwordTextField.text!)
        user.signUp{ (message) in
            if let unwrappedMessage = message {
                self.showAlert(message: unwrappedMessage)
                print("サインアップ失敗")
            } else {
                print("サインアップ成功")
            }
        }
    }
    
    
    func showAlert(message: String?) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
        
    }


}

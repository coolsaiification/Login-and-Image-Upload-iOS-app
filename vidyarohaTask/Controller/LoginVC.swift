//
//  LoginVC.swift
//  vidyarohaTask
//
//  Created by Sai on 22/01/18.
//  Copyright © 2018 Sai. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import FontAwesome_swift

class LoginVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var userNameTextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextFieldWithIcon!
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        userNameTextField.delegate = self
        userNameTextField.iconFont = UIFont.fontAwesome(ofSize: 20)
        userNameTextField.iconText = String.fontAwesomeIcon(name: .userCircle)
        passwordTextField.delegate = self
        passwordTextField.iconFont = UIFont.fontAwesome(ofSize: 20)
        passwordTextField.iconText = String.fontAwesomeIcon(name: .lock)
    }
    

    @IBAction func submitBtnPressed(_ sender: Any) {
        if userNameTextField.text == "Sai" && passwordTextField.text == "123456"{
            AuthService.instance.login(withUserName: userNameTextField.text!)
        }else{
            let alertController = UIAlertController(title: "Try Again", message: "Invalid username or password", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    //Hide keyboard when return key pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}


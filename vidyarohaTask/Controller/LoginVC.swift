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
        submitBtn.backgroundColor = UIColor.lightGray
        submitBtn.isEnabled = false
        
        userNameTextField.delegate = self
        userNameTextField.iconFont = UIFont.fontAwesome(ofSize: 20)
        userNameTextField.iconText = String.fontAwesomeIcon(name: .userCircle)
        userNameTextField.addTarget(self, action: #selector(LoginVC.textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        
        passwordTextField.delegate = self
        passwordTextField.iconFont = UIFont.fontAwesome(ofSize: 20)
        passwordTextField.iconText = String.fontAwesomeIcon(name: .lock)
        passwordTextField.addTarget(self, action: #selector(LoginVC.textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
    }
    

    @IBAction func submitBtnPressed(_ sender: UIButton) {
        sender.scaleAnimation {
            if self.userNameTextField.text == "Sai" && self.passwordTextField.text == "123456"{
                AuthService.instance.login(withUserName: self.userNameTextField.text!)
                self.presentImageScreen()
            }else{
                let alertController = UIAlertController(title: "Try Again", message: "Invalid username or password", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    
    func presentImageScreen(){
        //Open image screen
        guard let window = UIApplication.shared.keyWindow else { return }
        guard let rootViewController = window.rootViewController else { return }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let imageVc = storyboard.instantiateViewController(withIdentifier: GlobalConstants.VCIdentifiers.imageVC)
        imageVc.view.frame = rootViewController.view.frame
        imageVc.view.layoutIfNeeded()
        //Animate transition
        UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromRight, animations: {
            window.rootViewController = imageVc
        })
    }
    
    //Hide keyboard when return key pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if userNameTextField.text?.isEmpty ?? false || passwordTextField.text?.isEmpty ?? false {
            submitBtn.backgroundColor = UIColor.lightGray
            submitBtn.isEnabled = false
        } else{
            submitBtn.backgroundColor = #colorLiteral(red: 0.2901960784, green: 0.3019607843, blue: 0.8470588235, alpha: 1)
            submitBtn.isEnabled = true
        }
    }
    
}


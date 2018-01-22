//
//  LoginVC.swift
//  vidyarohaTask
//
//  Created by Sai on 22/01/18.
//  Copyright © 2018 Sai. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitBtn.layer.cornerRadius = 5
        submitBtn.clipsToBounds = true
    }
    

    @IBAction func submitBtnPressed(_ sender: Any) {
        if userNameTextField.text == "Sai" && passwordTextField.text == "123456"{
            let defaults = UserDefaults.standard
            defaults.set(userNameTextField.text, forKey: GlobalConstants.UserDefaultKeys.username)
            defaults.synchronize()
            setImageVCAsRootVC()
        }else{
            let alertController = UIAlertController(title: "Try Again", message: "Invalid username or password", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func setImageVCAsRootVC(){
        //Open image screen
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let imageVc = storyboard.instantiateViewController(withIdentifier: "ImageVC")
        appDelegate.window?.rootViewController = imageVc
        appDelegate.window?.makeKeyAndVisible()
    }
    
}


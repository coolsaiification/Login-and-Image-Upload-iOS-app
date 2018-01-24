//
//  ImageVC.swift
//  vidyarohaTask
//
//  Created by Sai on 22/01/18.
//  Copyright © 2018 Sai. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class ImageVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{

    @IBOutlet weak var profileImageBtn:UIButton!
    @IBOutlet weak var activityIndicator:NVActivityIndicatorView!
    var imagePicker = UIImagePickerController()
    
    var gradientLayer: CAGradientLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageBtn.layer.cornerRadius = profileImageBtn.frame.width/2
        profileImageBtn.clipsToBounds = true
        profileImageBtn.imageView?.contentMode = .scaleAspectFill
        activityIndicator.type = .ballClipRotate
    }
    
    @IBAction func pickImageBtnPressed(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum;
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func logoutBtnPressed(_ sender: Any) {
        //Clear user defaults
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: GlobalConstants.UserDefaultKeys.username)
        defaults.synchronize()
        setLoginVCAsRootVC()
    }
    
    func setLoginVCAsRootVC(){
        //Open login screen
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVc = storyboard.instantiateViewController(withIdentifier: "LoginVC")
        appDelegate.window?.rootViewController = loginVc
        appDelegate.window?.makeKeyAndVisible()
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true, completion: nil)
        //set button image
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            activityIndicator.startAnimating()
            profileImageBtn.setImage(pickedImage, for: .normal)
            //Upload image to server
            AuthService.instance.uploadImage(image: pickedImage, completion: { (success) in
                self.activityIndicator.stopAnimating()
                if success{
                    print("Image upload successful")
                }else{
                    print("Image upload unsuccessful")
                }
            })
        }
    }
    
    
}

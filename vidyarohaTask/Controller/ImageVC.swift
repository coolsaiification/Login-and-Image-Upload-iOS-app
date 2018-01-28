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
    @IBOutlet weak var tickImg: UIImageView!
    var imagePicker = UIImagePickerController()
    
    var gradientLayer: CAGradientLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageBtn.layer.cornerRadius = profileImageBtn.frame.width/2
        profileImageBtn.clipsToBounds = true
        profileImageBtn.imageView?.contentMode = .scaleAspectFill
        activityIndicator.type = .ballClipRotate
        tickImg.isHidden = true
    }
    
    @IBAction func pickImageBtnPressed(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func logoutBtnPressed(_ sender: UIButton) {
        sender.scaleAnimation {
            AuthService.instance.logout()
            self.presentLoginScreen()
        }
    }
    
    func presentLoginScreen(){
        //Open login screen
        guard let window = UIApplication.shared.keyWindow else { return }
        guard let rootViewController = window.rootViewController else { return }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVc = storyboard.instantiateViewController(withIdentifier: GlobalConstants.VCIdentifiers.loginVC)
        loginVc.view.frame = rootViewController.view.frame
        loginVc.view.layoutIfNeeded()
        //Animate transition
        UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromLeft, animations: {
            window.rootViewController = loginVc
        })
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true, completion: nil)
        //set button image
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.activityIndicator.startAnimating()
            self.tickImg.isHidden = true
            profileImageBtn.setImage(pickedImage, for: .normal)
            //Upload image to server
            AuthService.instance.uploadImage(image: pickedImage, completion: { (success) in
                print("Response received")
                var title:String = "Try Again"
                var msg:String = "mage upload was unsuccessful"
                if success{
                    print("Image upload successful")
                    title = "Success"
                    msg = "Image upload was successful"
                    DispatchQueue.main.async {
                        self.tickImg.isHidden = false
                        self.activityIndicator.stopAnimating()
                    }
                }else{
                    print("Image upload unsuccessful")
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                    }
                }
                let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
                
            })
        }
    }
    
    
}

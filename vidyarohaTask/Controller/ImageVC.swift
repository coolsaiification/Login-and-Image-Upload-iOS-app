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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageBtn.layer.cornerRadius = profileImageBtn.frame.width/2
        profileImageBtn.clipsToBounds = true
        profileImageBtn.imageView?.contentMode = .scaleAspectFill
        activityIndicator.type = .ballClipRotate
    }
    
    @IBAction func pickImageBtnPressed(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum;
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true, completion: nil)
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            activityIndicator.startAnimating()
            profileImageBtn.setImage(pickedImage, for: .normal)
        }
    }
}

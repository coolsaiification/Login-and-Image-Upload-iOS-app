//
//  AuthService.swift
//  vidyarohaTask
//
//  Created by Sai on 23/01/18.
//  Copyright © 2018 Sai. All rights reserved.
//

import Foundation
import Alamofire

class AuthService{
    static let instance = AuthService()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let defaults = UserDefaults.standard
    
    func uploadImage(image: UIImage, completion: @escaping(Bool)->()){
        let imgData = UIImageJPEGRepresentation(image, 0.2)!
        let url = GlobalConstants.api.uploadImage
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(imgData, withName: "fileset",fileName: "file.jpg", mimeType: "image/jpg")
        }, to: url) { result in
            switch result {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if response.result.error != nil{
                        completion(false)
                    } else{
                        completion(true)
                    }
                }
            case .failure(let encodingError):
                print(encodingError)
                completion(false)
            }
        }
    }
    
    func login(withUserName username:String){
        //Set user defaults
        defaults.set(username, forKey: GlobalConstants.UserDefaultKeys.username)
        defaults.synchronize()
        //Open image screen
        let imageVc = storyboard.instantiateViewController(withIdentifier: "ImageVC")
        appDelegate.window?.rootViewController = imageVc
        appDelegate.window?.makeKeyAndVisible()
    }
    
    func logout(){
        //Clear user defaults
        defaults.removeObject(forKey: GlobalConstants.UserDefaultKeys.username)
        defaults.synchronize()
        //Open login screen
        let loginVc = storyboard.instantiateViewController(withIdentifier: "LoginVC")
        appDelegate.window?.rootViewController = loginVc
        appDelegate.window?.makeKeyAndVisible()
    }
}

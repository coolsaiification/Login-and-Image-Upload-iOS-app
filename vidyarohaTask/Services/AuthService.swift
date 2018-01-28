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
    let defaults = UserDefaults.standard
    
    func uploadImage(image: UIImage, completion: @escaping(Bool)->()){
        let imgData = UIImageJPEGRepresentation(image, 0.2)!
        let url = GlobalConstants.Api.uploadImage
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(imgData, withName: "sampleFile",fileName: "sampleFile", mimeType: "image/jpg")
        }, to: url) { result in
            switch result {
            case .success(let upload, _, _):
                upload.responseString { response in
                    print(response)
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
    }
    
    func logout(){
        //Clear user defaults
        defaults.removeObject(forKey: GlobalConstants.UserDefaultKeys.username)
        defaults.synchronize()
    }
}

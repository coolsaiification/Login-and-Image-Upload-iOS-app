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
    
    func uploadImage(image: UIImage, completion: @escaping(Bool)->()){
        let imgData = UIImageJPEGRepresentation(image, 0.2)!
        let url = GlobalConstants.api.uploadImage
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(imgData, withName: "fileset",fileName: "file.jpg", mimeType: "image/jpg")
        }, to: url) { result in
            switch result {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print(response)
                    //Delay for testing activity indicator and tick
                    let timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (timer) in
                        completion(true)
                    }
                    RunLoop.current.add(timer, forMode: .commonModes)
                }
            case .failure(let encodingError):
                print(encodingError)
                completion(false)
            }
        }
    }
}

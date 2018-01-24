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
        let url = ""
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(imgData, withName: "fileset",fileName: "file.jpg", mimeType: "image/jpg")
        }, to: url) { result in
            switch result {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print(response.result.value ?? "")
                }
                completion(true)
            case .failure(let encodingError):
                print(encodingError)
                completion(false)
            }
        }
        completion(false)
    }
}

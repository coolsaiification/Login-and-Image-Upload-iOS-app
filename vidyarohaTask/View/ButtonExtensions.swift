//
//  ButtonExtensions.swift
//  vidyarohaTask
//
//  Created by Sai on 28/01/18.
//  Copyright © 2018 Sai. All rights reserved.
//

import UIKit

extension UIButton{
    func scaleAnimation(completion: @escaping(()->Void)){
        self.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        
        UIView.animate(withDuration: 2.0,
                        delay: 0,
                        usingSpringWithDamping: CGFloat(0.20),
                        initialSpringVelocity: CGFloat(6.0),
                        options: UIViewAnimationOptions.allowUserInteraction,
                        animations: {
                            self.transform = CGAffineTransform.identity
                        },
                        completion: { completed in
                            completion()
                        }
        )
    }
}

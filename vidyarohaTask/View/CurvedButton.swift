//
//  CurvedButton.swift
//  vidyarohaTask
//
//  Created by Sai on 24/01/18.
//  Copyright © 2018 Sai. All rights reserved.
//

import UIKit

@IBDesignable class CurvedButton: UIButton{
    
    @IBInspectable var cornerRadius: CGFloat = 5{
        didSet{
            self.setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
}

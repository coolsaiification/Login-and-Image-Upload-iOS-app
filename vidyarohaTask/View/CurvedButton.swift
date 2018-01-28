//
//  CurvedButton.swift
//  vidyarohaTask
//
//  Created by Sai on 24/01/18.
//  Copyright © 2018 Sai. All rights reserved.
//

import UIKit

//@IBDesignable
class CurvedButton: UIButton{
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    func setup() {
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
    }
}

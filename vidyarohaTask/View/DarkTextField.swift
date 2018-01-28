//
//  DarkTextField.swift
//  vidyarohaTask
//
//  Created by Sai on 24/01/18.
//  Copyright © 2018 Sai. All rights reserved.
//

import UIKit

//@IBDesignable
class DarkTextField: UITextField {
    
    @IBInspectable var color: UIColor = UIColor.lightGray {
        didSet {
            updateView()
        }
    }
    func updateView() {
        
        // Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: color])
    }

}

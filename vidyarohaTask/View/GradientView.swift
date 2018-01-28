//
//  GradientView.swift
//  vidyarohaTask
//
//  Created by Sai on 24/01/18.
//  Copyright © 2018 Sai. All rights reserved.
//

import UIKit

@IBDesignable class GradientView: UIView{
    
    @IBInspectable var topColor: UIColor = #colorLiteral(red: 0.6980392157, green: 0.1803921569, blue: 0.4549019608, alpha: 1){
        didSet{
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var bottomColor: UIColor = #colorLiteral(red: 0.04705882353, green: 0.2666666667, blue: 0.5882352941, alpha: 1){
        didSet{
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var gradientAlignment: Int = 1{
        didSet{
            self.setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        switch gradientAlignment{
        case 1:
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        case 2:
            gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        case 3:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        default:
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        }
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

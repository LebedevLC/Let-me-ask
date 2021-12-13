//
//  MyButton.swift
//  Let me ask
//
//  Created by Сергей Чумовских  on 04.12.2021.
//

import Foundation
import UIKit

class MyButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
    
    func setupUI() {
        let colors = [
            UIColor(red: 1.000, green: 0.831, blue: 0.322, alpha: 1),
            UIColor(red: 0.941, green: 0.502, blue: 0.502, alpha: 1),
        ]
        
        let colorTop = colors[0].cgColor
        let colorBottom = colors[1].cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.3]
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 16
        self.layer.masksToBounds = true
    }
}

//
//  AppDefaults.swift
//  Which Stream
//
//  Created by Leo Oliveira on 11/4/18.
//  Copyright © 2018 Which. All rights reserved.
//

import UIKit

class AppDefaults {
    
    /**
     Creates a color gradient and sets it as the background
     
     - Version: 1.0
     - Author: Leo Oliveira
     */
    func setupBackgroundGradientFor(view: UIView) -> UIView {
        view.backgroundColor = .clear
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        gradientLayer.colors = [UIColor(hex: "5d0028").cgColor, UIColor(hex: "c96548").cgColor]
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        return view
    }
}

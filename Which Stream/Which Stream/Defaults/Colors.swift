//
//  Colors.swift
//  Which Stream
//
//  Created by Leo Oliveira on 6/22/19.
//  Copyright © 2019 Whcih. All rights reserved.
//

import UIKit

extension UIColor {
    
    /**
     Extends UIColor to allow for using specific colors based on their hex values.
     
     - Version: 1.0
     - Author: Leo Oliveira
     */
    convenience init(hex: String) {
        // convenience keyword indicates which initializers can be inherited by
        // subclasses that add instance variables without default values
        
        // Scan string for a hexadecimal representation
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        var rgb: UInt64 = 0
        // Inout reference to rgb (passes it by reference and not by value)
        scanner.scanHexInt64(&rgb)
        
        // Bitmasking and bitshifting to obtain appropriate values
        let r = CGFloat((rgb & 0xff0000) >> 16)/255.0
        let g = CGFloat((rgb & 0xff00) >> 8)/255.0
        let b = CGFloat(rgb & 0xff)/255.0
        
        self.init(red: r, green: g, blue: b, alpha: 1)
    }
}

extension UIView {
    /**
     Creates a color gradient and sets it as the background
     
     - Version: 1.0
     - Author: Leo Oliveira
     */
    func setBackgroundGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        gradientLayer.colors = [Colors.burgundy.cgColor, Colors.orange.cgColor]
        layer.insertSublayer(gradientLayer, at: 0)
    }
}

struct Colors {
    static let burgundy = UIColor(hex: "5d0028")
    static let orange = UIColor(hex: "c96548")
    static let purple = UIColor(hex: "5d0028")
    static let blue = UIColor(hex: "003b56")
}

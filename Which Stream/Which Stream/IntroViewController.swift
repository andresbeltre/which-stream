//
//  ViewController.swift
//  Which Stream
//
//  Created by Andrés Beltré on 7/22/18.
//  Copyright © 2018 Whcih. All rights reserved.
//

import UIKit

extension UIColor {
    // convenience keyword indicates which initializers can be inherited by
    // subclasses that add instance variables without default values
    convenience init(hex: String) {
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
class IntroViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackgroundGradient()
        setupLayout()
    }
    
    func setupLayout() {
        // Hide navigation bar
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        // Programatically create buttons
        let loginButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 20))
        loginButton.titleLabel?.textColor = .white
        loginButton.addTarget(self, action: #selector(loginSegue), for: .touchUpInside)
        let registerButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 20))
        registerButton.titleLabel?.textColor = .white
        registerButton.addTarget(self, action: #selector(registerSegue), for: .touchUpInside)
        let guestButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 20))
        guestButton.titleLabel?.textColor = .white
        guestButton.addTarget(self, action: #selector(guestSegue), for: .touchUpInside)
        
        // Assign correct text to respective buttons
        loginButton.setTitle("Login", for: .normal)
        registerButton.setTitle("Register", for: .normal)
        guestButton.setTitle("Guest", for: .normal)
        
        // Add buttons to view
        self.view.addSubview(loginButton)
        self.view.addSubview(registerButton)
        self.view.addSubview(guestButton)
        
        // Set translatesAutoresizingMaskIntoConstraints to false
        // since we're programatically creating the constraints
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        guestButton.translatesAutoresizingMaskIntoConstraints = false
        // Constraints for login button
        loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        loginButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 40).isActive = true
        // Constraints for register button
        registerButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10).isActive = true
        // Constraints for guest button
        guestButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        guestButton.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 10).isActive = true
    }
    
    func setupBackgroundGradient() {
        self.view.backgroundColor = .clear
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        gradientLayer.colors = [UIColor(hex: "5d0028").cgColor, UIColor(hex: "c96548").cgColor]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }

    @objc func loginSegue() {
        self.performSegue(withIdentifier: "toLoginSegue", sender: self)
    }
    
    @objc func registerSegue() {
        self.performSegue(withIdentifier: "toRegisterSegue", sender: self)
    }
    
    @objc func guestSegue() {

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


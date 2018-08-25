//
//  LoginViewController.swift
//  Which Stream
//
//  Created by Leo Oliveira on 8/24/18.
//  Copyright © 2018 Whcih. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackgroundGradient()
        setupLayout()
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
    
    func setupLayout() {
        // Hide navigation bar
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        // Programatically create buttons, text fields, and labels
        let loginButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 20))
        loginButton.titleLabel?.textColor = .white
        loginButton.addTarget(self, action: #selector(normalAuthentication), for: .touchUpInside)
        let cancelButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 20))
        cancelButton.titleLabel?.textColor = .white
        cancelButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        let facebookButton = UIButton(frame: CGRect(x: 0, y: 0, width: 120, height: 20))
        facebookButton.titleLabel?.textColor = .white
        facebookButton.addTarget(self, action: #selector(facebookAuthentication), for: .touchUpInside)
        let forgotPassButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 20))
        forgotPassButton.titleLabel?.textColor = .white
        forgotPassButton.addTarget(self, action: #selector(forgotPassSegue), for: .touchUpInside)
        
        // Assign correct text to respective buttons
        loginButton.setTitle("Login", for: .normal)
        cancelButton.setTitle("Cancel", for: .normal)
        facebookButton.setTitle("Login with Facebook", for: .normal)
        forgotPassButton.setTitle("Forgot Password?", for: .normal)
        
        // Add buttons to view
        self.view.addSubview(loginButton)
        self.view.addSubview(cancelButton)
        self.view.addSubview(facebookButton)
        self.view.addSubview(forgotPassButton)
        forgotPassButton.isHidden = true
        
        // Set translatesAutoresizingMaskIntoConstraints to false
        // since we're programatically creating the constraints
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        facebookButton.translatesAutoresizingMaskIntoConstraints = false
        forgotPassButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Constraints for login button
        loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 60).isActive = true
        loginButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 90).isActive = true
        // Constraints for cancel button
        cancelButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -55).isActive = true
        cancelButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 90).isActive = true
        // Constraints for facebook button
        facebookButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        facebookButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20).isActive = true
    }
    
    @objc func normalAuthentication() {
        
    }
    
    @objc func facebookAuthentication() {
        
    }
    
    @objc func dismissView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func forgotPassSegue() {
        
    }
}

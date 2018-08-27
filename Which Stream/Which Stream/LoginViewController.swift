//
//  LoginViewController.swift
//  Which Stream
//
//  Created by Leo Oliveira on 8/24/18.
//  Copyright © 2018 Whcih. All rights reserved.
//

import UIKit

extension UITextField {

    func setBottomBorder() {
        self.borderStyle = .none
        self.backgroundColor = .clear
        
        let borderLine = UIView(frame: CGRect(x: 0, y: self.frame.height - 1, width: self.frame.width * 3, height: 1))
        borderLine.backgroundColor = .white
        self.layer.masksToBounds = true
        self.addSubview(borderLine)
    }
}
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
        loginButton.addTarget(self, action: #selector(firebaseAuthentication), for: .touchUpInside)
        let cancelButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 20))
        cancelButton.titleLabel?.textColor = .white
        cancelButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        let facebookButton = UIButton(frame: CGRect(x: 0, y: 0, width: 120, height: 20))
        facebookButton.titleLabel?.textColor = .white
        facebookButton.addTarget(self, action: #selector(facebookAuthentication), for: .touchUpInside)
        let forgotPassButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 20))
        forgotPassButton.titleLabel?.textColor = .white
        forgotPassButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        forgotPassButton.addTarget(self, action: #selector(forgotPassSegue), for: .touchUpInside)
        
        let emailLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 20))
        emailLabel.textColor = .white
        let passLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 20))
        passLabel.textColor = .white
        let emailInput = UITextField(frame: CGRect(x: 0, y: 0, width: 120, height: 20))
        emailInput.textColor = .white
        emailInput.setBottomBorder()
        let passInput = UITextField(frame: CGRect(x: 0, y: 0, width: 120, height: 20))
        passInput.textColor = .white
        passInput.isSecureTextEntry = true
        passInput.setBottomBorder()
        
        // Assign correct text to respective labels
        emailLabel.text = "Email:"
        passLabel.text = "Password:"
            
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
        self.view.addSubview(emailLabel)
        self.view.addSubview(passLabel)
        self.view.addSubview(emailInput)
        self.view.addSubview(passInput)
//        forgotPassButton.isHidden = true
        
        // Set translatesAutoresizingMaskIntoConstraints to false
        // since we're programatically creating the constraints
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        facebookButton.translatesAutoresizingMaskIntoConstraints = false
        forgotPassButton.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        passLabel.translatesAutoresizingMaskIntoConstraints = false
        emailInput.translatesAutoresizingMaskIntoConstraints = false
        passInput.translatesAutoresizingMaskIntoConstraints = false
        
        // Constraints for login button
        loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 60).isActive = true
        loginButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 110).isActive = true
        // Constraints for cancel button
        cancelButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -55).isActive = true
        cancelButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 110).isActive = true
        // Constraints for facebook button
        facebookButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        facebookButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20).isActive = true
        emailLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 80).isActive = true
        emailLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -60).isActive = true
        emailInput.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 80).isActive = true
        emailInput.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -80).isActive = true
        emailInput.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10).isActive = true
        passLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 80).isActive = true
        passLabel.topAnchor.constraint(equalTo: emailInput.bottomAnchor, constant: 5).isActive = true
        passInput.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 80).isActive = true
        passInput.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -80).isActive = true
        passInput.topAnchor.constraint(equalTo: passLabel.bottomAnchor, constant: 10).isActive = true
        forgotPassButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -80).isActive = true
        forgotPassButton.topAnchor.constraint(equalTo: passInput.bottomAnchor, constant: 5).isActive = true
    }
    
    @objc func firebaseAuthentication() {
        
    }
    
    @objc func facebookAuthentication() {
        
    }
    
    @objc func dismissView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func forgotPassSegue() {
        
    }
}

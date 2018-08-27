//
//  RegisterViewController.swift
//  Which Stream
//
//  Created by Leo Oliveira on 8/24/18.
//  Copyright © 2018 Whcih. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackgroundGradient()
        setupLayout()
    }
    
    
    func setupLayout() {
        // Hide navigation bar
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        // Programatically create buttons, text fields, and labels
        let registerButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 20))
        registerButton.titleLabel?.textColor = .white
        registerButton.addTarget(self, action: #selector(sendEmail), for: .touchUpInside)

        
        let usernameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 20))
        usernameLabel.textColor = .white
        let emailLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 20))
        emailLabel.textColor = .white
        let passwordLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 120, height: 20))
        passwordLabel.textColor = .white
        let retypePasswordLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 120, height: 20))
        retypePasswordLabel.textColor = .white
        let usernameInput = UITextField(frame: CGRect(x: 0, y: 0, width: 120, height: 20))
        let emailInput = UITextField(frame: CGRect(x: 0, y: 0, width: 120, height: 20))
        let passInput = UITextField(frame: CGRect(x: 0, y: 0, width: 120, height: 20))
        let retypePassInput = UITextField(frame: CGRect(x: 0, y: 0, width: 120, height: 20))
        
        // Assign correct text to respective labels
        usernameLabel.text = "Username:"
        emailLabel.text = "Email:"
        passwordLabel.text = "Password:"
        retypePasswordLabel.text = "Retype Password:"
        
        // Assign correct text to respective buttons
        registerButton.setTitle("Register", for: .normal)
        
        // Add buttons to view
        self.view.addSubview(registerButton)
        self.view.addSubview(usernameLabel)
        self.view.addSubview(emailLabel)
        self.view.addSubview(passwordLabel)
        self.view.addSubview(retypePasswordLabel)
        self.view.addSubview(usernameInput)
        self.view.addSubview(emailInput)
        self.view.addSubview(passInput)
        self.view.addSubview(retypePassInput)
 
        // Set translatesAutoresizingMaskIntoConstraints to false
        // since we're programatically creating the constraints
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        retypePasswordLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameInput.translatesAutoresizingMaskIntoConstraints = false
        emailInput.translatesAutoresizingMaskIntoConstraints = false
        passInput.translatesAutoresizingMaskIntoConstraints = false
        retypePassInput.translatesAutoresizingMaskIntoConstraints = false
        
        
        usernameLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 80).isActive = true
        usernameLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -80).isActive = true
        usernameLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -60).isActive = true
        usernameInput.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 80).isActive = true
        usernameInput.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -80).isActive = true
        usernameInput.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 10).isActive = true
        usernameInput.setBottomBorder()
        emailLabel.topAnchor.constraint(equalTo: usernameInput.bottomAnchor, constant: 5).isActive = true
        emailLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 80).isActive = true
        emailLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -80).isActive = true
        emailInput.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10).isActive = true
        emailInput.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 80).isActive = true
        emailInput.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -80).isActive = true
        emailInput.setBottomBorder()
        passwordLabel.topAnchor.constraint(equalTo: emailInput.bottomAnchor, constant: 5).isActive = true
        passwordLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 80).isActive = true
        passwordLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -80).isActive = true
        passInput.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 10).isActive = true
        passInput.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 80).isActive = true
        passInput.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -80).isActive = true
        passInput.setBottomBorder()
        retypePasswordLabel.topAnchor.constraint(equalTo: passInput.bottomAnchor, constant: 5).isActive = true
        retypePasswordLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 80).isActive = true
        retypePasswordLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -80).isActive = true
        retypePassInput.topAnchor.constraint(equalTo: retypePasswordLabel.bottomAnchor, constant: 10).isActive = true
        retypePassInput.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 80).isActive = true
        retypePassInput.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -80).isActive = true
        retypePassInput.setBottomBorder()
        // Constraints for register button
        registerButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        registerButton.topAnchor.constraint(equalTo: retypePassInput.bottomAnchor, constant: 20).isActive = true
        
    }
    
    @objc func sendEmail() {
        
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
    
}

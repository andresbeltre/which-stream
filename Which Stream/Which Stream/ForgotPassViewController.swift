//
//  ForgotPassViewController.swift
//  Which Stream
//
//  Created by Leo Oliveira on 9/28/18.
//  Copyright © 2018 Which. All rights reserved.
//

import UIKit

class ForgotPassViewController: UIViewController, UITextFieldDelegate {
    
    let APP_DEFAULTS = AppDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = APP_DEFAULTS.setupBackgroundGradientFor(view: self.view)
        setupLayout()
    }
    
    /**
     Function to instantiate view elements and processes.
     
     - Version: 1.0
     - Author: Leo Oliveira
     */
    func setupLayout() {
        // Create view elements
        let title = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        title.textAlignment = .center
        title.text = "Forgot Password?"
        title.font = UIFont.boldSystemFont(ofSize: 20)
        title.textColor = .white
        let description = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        description.text = "Enter your email address to retrieve your password."
        description.textColor = .white
        description.numberOfLines = 2
        let emailInput = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        emailInput.delegate = self
        emailInput.setBottomBorder()
        emailInput.textColor = .white
        let submitButton = UIButton(type: .system)
        submitButton.frame = CGRect(x: 0, y: 0, width: 100, height: 20)
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        submitButton.titleLabel?.textAlignment = .right
        let cancelButton = UIButton(type: .system)
        cancelButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        cancelButton.frame = CGRect(x: 0, y: 0, width: 100, height: 20)
        cancelButton.setTitle("Back to Login", for: .normal)
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        cancelButton.titleLabel?.textAlignment = .right
        
        // Add elements as subviews
        self.view.addSubview(title)
        self.view.addSubview(description)
        self.view.addSubview(emailInput)
        self.view.addSubview(submitButton)
        self.view.addSubview(cancelButton)
        
        // Add constraints
        title.translatesAutoresizingMaskIntoConstraints = false
        description.translatesAutoresizingMaskIntoConstraints = false
        emailInput.translatesAutoresizingMaskIntoConstraints = false
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        description.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -10).isActive = true
        description.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        description.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 80).isActive = true
        description.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -80).isActive = true
        
        emailInput.topAnchor.constraint(equalTo: description.bottomAnchor, constant: 20).isActive = true
        emailInput.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        emailInput.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 80).isActive = true
        emailInput.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -80).isActive = true
        
        title.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        title.bottomAnchor.constraint(equalTo: description.topAnchor, constant: -100).isActive = true
        title.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 80).isActive = true
        title.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -80).isActive = true
        
        submitButton.topAnchor.constraint(equalTo: emailInput.bottomAnchor, constant: 10).isActive = true
        submitButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -80).isActive = true
        
        cancelButton.topAnchor.constraint(equalTo: submitButton.bottomAnchor).isActive = true
        cancelButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -80).isActive = true
        
    }
    
    
    /**
     Function to dismiss view upon being called
     
     - Version: 1.0
     - Author: Leo Oliveira
     */
    @objc func dismissView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    /**
     Dismisses keyboard and removes focus from a specific text field
     
     - Version: 1.0
     - Author: Leo Oliveira
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

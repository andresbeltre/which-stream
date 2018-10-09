//
//  RegisterViewController.swift
//  Which Stream
//
//  Created by Leo Oliveira on 8/24/18.
//  Copyright © 2018 Whcih. All rights reserved.
//

import Firebase
import FirebaseAuth
import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    var viewMoved = false
    var usernameInput = UITextField()
    var emailInput = UITextField()
    var passInput = UITextField()
    var retypePassInput = UITextField()
    
    var containerView = UIView()
    var usernameValid = UIView()
    var emailValid = UIView()
    var passValid = UIView()
    var retypeValid = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        setupBackgroundGradient()
        setupLayout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if (viewMoved != true) {
            viewMoved = true
            self.containerView.frame.origin.y -= 150
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if (viewMoved == true) {
            viewMoved = false
            self.containerView.frame.origin.y += 150
        }
    }
    
    func setupLayout() {
        
        // Create container view
        containerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        containerView.backgroundColor = .clear
        self.view.addSubview(containerView)
        
        // Create logo image instance
        let whichLogo = UIImageView(frame: CGRect(x: (self.view.frame.width/2 - 150), y: 80, width: 300, height: 150))
        // Add Logo to view
        self.containerView.addSubview(whichLogo)
        // Add the image to the respective element
        let logoImage = UIImage(named: "WhichLogo")
        whichLogo.image = logoImage
        whichLogo.contentMode = .scaleAspectFit
        
        // Hide navigation bar
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        // Programatically create buttons, text fields, and labels
        let registerButton = UIButton(type: .system)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.addTarget(self, action: #selector(sendEmail), for: .touchUpInside)
        
        let cancelButton = UIButton(type: .system)
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        
        let usernameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 20))
        usernameLabel.textColor = .white
        let emailLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 20))
        emailLabel.textColor = .white
        let passwordLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 120, height: 20))
        passwordLabel.textColor = .white
        let retypePasswordLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 120, height: 20))
        retypePasswordLabel.textColor = .white
        self.usernameInput = UITextField(frame: CGRect(x: 0, y: 0, width: 120, height: 20))
        self.usernameInput.delegate = self
        self.usernameInput.textColor = .white
        self.emailInput = UITextField(frame: CGRect(x: 0, y: 0, width: 120, height: 20))
        self.emailInput.delegate = self
        self.emailInput.textColor = .white
        self.passInput = UITextField(frame: CGRect(x: 0, y: 0, width: 120, height: 20))
        self.passInput.delegate = self
        self.passInput.textColor = .white
        self.passInput.isSecureTextEntry = true
        self.retypePassInput = UITextField(frame: CGRect(x: 0, y: 0, width: 120, height: 20))
        self.retypePassInput.delegate = self
        self.retypePassInput.textColor = .white
        self.retypePassInput.isSecureTextEntry = true
        
        self.usernameValid = UIView(frame: CGRect(x: 60, y: self.view.center.y - 65, width: 10, height: 10))
        self.usernameValid.layer.cornerRadius = self.usernameValid.frame.width/2
        self.usernameValid.clipsToBounds = true
        self.usernameValid.backgroundColor = .red
        self.emailValid = UIView(frame: CGRect(x: 60, y: self.view.center.y - 8, width: 10, height: 10))
        self.emailValid.layer.cornerRadius = self.emailValid.frame.width/2
        self.emailValid.clipsToBounds = true
        self.emailValid.backgroundColor = .red
        self.passValid = UIView(frame: CGRect(x: 60, y: self.view.center.y + 48, width: 10, height: 10))
        self.passValid.layer.cornerRadius = self.passValid.frame.width/2
        self.passValid.backgroundColor = .red
        self.retypeValid = UIView(frame: CGRect(x: 60, y: self.view.center.y + 105, width: 10, height: 10))
        self.retypeValid.layer.cornerRadius = self.retypeValid.frame.width/2
        self.retypeValid.backgroundColor = .red
        
        
        // Hide the alert buttons from initial load
        self.usernameValid.isHidden = true
        self.emailValid.isHidden = true
        self.passValid.isHidden = true
        self.retypeValid.isHidden = true
        
        // Assign correct text to respective labels
        usernameLabel.text = "Username:"
        emailLabel.text = "Email:"
        passwordLabel.text = "Password:"
        retypePasswordLabel.text = "Retype Password:"
        
        // Assign correct text to respective buttons
        registerButton.setTitle("Register", for: .normal)
        registerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        // Add buttons to view
        self.containerView.addSubview(registerButton)
        self.containerView.addSubview(cancelButton)
        self.containerView.addSubview(usernameLabel)
        self.containerView.addSubview(emailLabel)
        self.containerView.addSubview(passwordLabel)
        self.containerView.addSubview(retypePasswordLabel)
        self.containerView.addSubview(self.usernameInput)
        self.containerView.addSubview(self.emailInput)
        self.containerView.addSubview(self.passInput)
        self.containerView.addSubview(self.retypePassInput)
        self.containerView.addSubview(self.usernameValid)
        self.containerView.addSubview(self.emailValid)
        self.containerView.addSubview(self.passValid)
        self.containerView.addSubview(self.retypeValid)
 
        // Set translatesAutoresizingMaskIntoConstraints to false
        // since we're programatically creating the constraints
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        retypePasswordLabel.translatesAutoresizingMaskIntoConstraints = false
        self.usernameInput.translatesAutoresizingMaskIntoConstraints = false
        self.emailInput.translatesAutoresizingMaskIntoConstraints = false
        self.passInput.translatesAutoresizingMaskIntoConstraints = false
        self.retypePassInput.translatesAutoresizingMaskIntoConstraints = false
        
        
        usernameLabel.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 80).isActive = true
        usernameLabel.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -80).isActive = true
        usernameLabel.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor, constant: -60).isActive = true
        self.usernameInput.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 80).isActive = true
        self.usernameInput.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -80).isActive = true
        self.usernameInput.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 10).isActive = true
        self.usernameInput.setBottomBorder()
        emailLabel.topAnchor.constraint(equalTo: self.usernameInput.bottomAnchor, constant: 5).isActive = true
        emailLabel.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 80).isActive = true
        emailLabel.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -80).isActive = true
        self.emailInput.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10).isActive = true
        self.emailInput.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 80).isActive = true
        self.emailInput.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -80).isActive = true
        self.emailInput.setBottomBorder()
        passwordLabel.topAnchor.constraint(equalTo: self.emailInput.bottomAnchor, constant: 5).isActive = true
        passwordLabel.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 80).isActive = true
        passwordLabel.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -80).isActive = true
        self.passInput.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 10).isActive = true
        self.passInput.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 80).isActive = true
        self.passInput.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -80).isActive = true
        self.passInput.setBottomBorder()
        retypePasswordLabel.topAnchor.constraint(equalTo: self.passInput.bottomAnchor, constant: 5).isActive = true
        retypePasswordLabel.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 80).isActive = true
        retypePasswordLabel.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -80).isActive = true
        self.retypePassInput.topAnchor.constraint(equalTo: retypePasswordLabel.bottomAnchor, constant: 10).isActive = true
        self.retypePassInput.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 80).isActive = true
        self.retypePassInput.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -80).isActive = true
        self.retypePassInput.setBottomBorder()
        // Constraints for register button
        registerButton.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -80).isActive = true
        registerButton.topAnchor.constraint(equalTo: self.retypePassInput.bottomAnchor, constant: 20).isActive = true
        // Constraints for cancel button
        cancelButton.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 80).isActive = true
        cancelButton.topAnchor.constraint(equalTo: self.retypePassInput.bottomAnchor, constant: 20).isActive = true
    }
    
    @objc func dismissView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func sendEmail() {
        if usernameValid.backgroundColor == UIColor.green && emailValid.backgroundColor == UIColor.green && retypeValid.backgroundColor == UIColor.green {
            Auth.auth().createUser(withEmail: emailInput.text!, password: passInput.text!, completion: { (user, authError) in
                Auth.auth().currentUser?.sendEmailVerification { (emailError) in
                    if emailError != nil {
                        let alert = UIAlertController(title: "Error", message: "Failed to send the verification email. Try logging in and we will try sending you a verification email again.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    } else {
                        if authError == nil {
                            let alert = UIAlertController(title: "Verify your email", message: "We have just sent you an email. Please verify your email address to start using Wh!ch", preferredStyle: .alert)
                            let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                                self.navigationController?.popViewController(animated: true)
                            })
                            alert.addAction(ok)
                            self.present(alert, animated: true, completion: nil)
                        } else {
                            if (self.passInput.text!.count < 6) {
                                let alert = UIAlertController(title: "Invalid Password", message: "Passwords must be at least 6 characters long", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                            } else {
                                let alert = UIAlertController(title: "Error signing up", message: "An error has occurred. Please check your internet connection and try again", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                            }
                        }
                    }
                }
            })
        } else {
            let alert = UIAlertController(title: "Unable to Register", message: "One or more fields are invalid. Please check your input and try again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
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
    
    // Dismisses keyboard and removes the focus from a specific text field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField == self.usernameInput) {
            if (!textField.text!.isEmpty) {
                // Check database to see if username already exists
                self.usernameValid.backgroundColor = .green
                self.usernameValid.isHidden = false
            } else {
                self.usernameValid.backgroundColor = .red
                self.usernameValid.isHidden = false
            }
        } else if (textField == self.emailInput) {
            if (!textField.text!.isEmpty) {
                // Check database to see if email has already been registered
                self.emailValid.backgroundColor = .green
                self.emailValid.isHidden = false
            } else {
                self.emailValid.backgroundColor = .red
                self.emailValid.isHidden = false
            }
        } else if (textField == self.passInput) {
            if (!textField.text!.isEmpty) {
                // Check to see if password is long enough
                self.passValid.backgroundColor = .green
                self.passValid.isHidden = false
            } else {
                self.passValid.backgroundColor = .red
                self.passValid.isHidden = false
            }
            
            if (self.retypePassInput.text == self.passInput.text && !(self.retypePassInput.text?.isEmpty)!) {
                self.retypeValid.backgroundColor = .green
            } else {
                self.retypeValid.backgroundColor = .red
            }
        } else if (textField == self.retypePassInput) {
            if (!textField.text!.isEmpty) {
                // Check to see if password matches
                if (textField.text == self.passInput.text) {
                    // Approve
                    self.retypeValid.backgroundColor = .green
                    self.retypeValid.isHidden = false
                } else {
                    // Deny
                    self.retypeValid.backgroundColor = .red
                    self.retypeValid.isHidden = false
                }
            } else {
                self.retypeValid.backgroundColor = .red
                self.retypeValid.isHidden = false
            }
        }
    }
}

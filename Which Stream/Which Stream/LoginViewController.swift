//
//  LoginViewController.swift
//  Which Stream
//
//  Created by Leo Oliveira on 8/24/18.
//  Copyright © 2018 Which. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FBSDKLoginKit

extension UITextField {

    /**
     Extends the text field and allows them to have a bottom border (for visual purposes)
     
     - Version: 1.0
     - Author: Leo Oliveira
     */
    func setBottomBorder() {
        self.borderStyle = .none
        self.backgroundColor = .clear
        
        let borderLine = UIView(frame: CGRect(x: 0, y: self.frame.height - 1, width: self.frame.width * 3, height: 1))
        borderLine.backgroundColor = .white
        self.layer.masksToBounds = true
        self.addSubview(borderLine)
    }
}
class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var usersRef: DocumentReference!
    var emailInput = UITextField()
    var passInput = UITextField()
    let APP_DEFAULTS = AppDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        usersRef = Firestore.firestore().document("users")
        self.view = APP_DEFAULTS.setupBackgroundGradientFor(view: self.view)
        setupLayout()
    }
    
    /**
     Sets up the initial elements of the view.
     
     - Version: 1.0
     - Author: Leo Oliveira
     */
    func setupLayout() {
        // Create logo image instance
        let whichLogo = UIImageView(frame: CGRect(x: (self.view.frame.width/2 - 150), y: 80, width: 300, height: 150))
        whichLogo.image = #imageLiteral(resourceName: "LogoString")
        whichLogo.contentMode = .scaleAspectFit
        // Add Logo to view
        self.view.addSubview(whichLogo)
        
        // Hide navigation bar
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        // Programatically create buttons, text fields, and labels
        let loginButton = UIButton(type: .system)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.addTarget(self, action: #selector(firebaseAuthentication), for: .touchUpInside)
        let cancelButton = UIButton(type: .system)
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        let facebookButton = UIButton(type: .system)
        facebookButton.setTitleColor(.white, for: .normal)
        facebookButton.addTarget(self, action: #selector(facebookAuthentication), for: .touchUpInside)
        let forgotPassButton = UIButton(type: .system)
        forgotPassButton.setTitleColor(.white, for: .normal)
        forgotPassButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        forgotPassButton.addTarget(self, action: #selector(forgotPassSegue), for: .touchUpInside)
        // Assign correct text to respective buttons
        loginButton.setTitle("Login", for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        facebookButton.setTitle("Login with Facebook", for: .normal)
        facebookButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        forgotPassButton.setTitle("Forgot Password?", for: .normal)
        
        
        let separatorLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 20))
        separatorLabel.textColor = .white
        separatorLabel.textAlignment = .center
        let emailLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 20))
        emailLabel.textColor = .white
        let passLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 20))
        passLabel.textColor = .white
        emailInput = UITextField(frame: CGRect(x: 0, y: 0, width: 120, height: 20))
        emailInput.textColor = .white
        emailInput.delegate = self
        emailInput.setBottomBorder()
        passInput = UITextField(frame: CGRect(x: 0, y: 0, width: 120, height: 20))
        passInput.textColor = .white
        passInput.isSecureTextEntry = true
        passInput.delegate = self 
        passInput.setBottomBorder()
        
        // Assign correct text to respective labels
        separatorLabel.text = "OR"
        separatorLabel.font = UIFont.boldSystemFont(ofSize: 20)
        emailLabel.text = "Email:"
        passLabel.text = "Password:"
        
        // Add elements as subview
        self.view.addSubview(loginButton)
        self.view.addSubview(cancelButton)
        self.view.addSubview(facebookButton)
        self.view.addSubview(forgotPassButton)
        self.view.addSubview(separatorLabel)
        self.view.addSubview(emailLabel)
        self.view.addSubview(passLabel)
        self.view.addSubview(emailInput)
        self.view.addSubview(passInput)
        
        // Set translatesAutoresizingMaskIntoConstraints to false
        // since we're programatically creating the constraints
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        facebookButton.translatesAutoresizingMaskIntoConstraints = false
        forgotPassButton.translatesAutoresizingMaskIntoConstraints = false
        separatorLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        passLabel.translatesAutoresizingMaskIntoConstraints = false
        emailInput.translatesAutoresizingMaskIntoConstraints = false
        passInput.translatesAutoresizingMaskIntoConstraints = false
        
        // Constraints for login button
        loginButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -80).isActive = true
        loginButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 110).isActive = true
        // Constraints for cancel button
        cancelButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 80).isActive = true
        cancelButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 110).isActive = true
        // Constraints for separator label
        separatorLabel.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 20).isActive = true
        separatorLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 80).isActive = true
        separatorLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -80).isActive = true
        // Constraints for facebook button
        facebookButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        facebookButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 80).isActive = true
        facebookButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -80).isActive = true
        facebookButton.topAnchor.constraint(equalTo: separatorLabel.bottomAnchor, constant: 20).isActive = true
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    /**
     Authenticate the user with the Firebase service.
     
     - Version: 1.0
     - Author: Leo Oliveira
     */
    @objc func firebaseAuthentication() {
        if (emailInput.text == "" || self.passInput.text == "") {
            let alert = UIAlertController(title: "Error", message: "Please type in your email and password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            Auth.auth().signIn(withEmail: emailInput.text!, password: passInput.text!, completion: { (user, error) in
                if let user = Auth.auth().currentUser {
                    if user.isEmailVerified {
                        if error == nil {
                            self.navigationController?.pushViewController(MainViewController(), animated: true)
                        } else {
                            let alert = UIAlertController(title: "Error", message: "Invalid email or password. Please check your input and try again", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                    } else {
                        // If it is, ask if user wants verification email sent again
                        let alert = UIAlertController(title: "Verify your account", message: "Would you like us to send you the verification email again?", preferredStyle: .alert)
                        let yes = UIAlertAction(title: "Yes", style: .default, handler: { action in
                            Auth.auth().currentUser?.sendEmailVerification { (emailError) in
                                if emailError != nil {
                                    let alert = UIAlertController(title: "Error", message: "Failed to send the verification email. Please try logging in again and we will try sending you a verification email.", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                    self.present(alert, animated: true, completion: nil)
                                } else {
                                    let alert = UIAlertController(title: "Email Sent", message: "We have sent you a verification email. Check your inbox and spam folder; if you don't receive the email, try logging in again and we will send you a new verification email.", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                    self.present(alert, animated: true, completion: nil)
                                }
                            }
                        })
                        let no = UIAlertAction(title: "No", style: .default, handler: nil)
                        alert.addAction(yes)
                        alert.addAction(no)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            })
        }
    }
    
    /**
     Authenticate the user with the Facebook service.
     
     - Version: 1.0
     - Author: Leo Oliveira
     */
    @objc func facebookAuthentication() {
        let fbManager = FBSDKLoginManager()
        fbManager.logIn(withReadPermissions: ["email"], from: self, handler: { (result, error) -> Void in
            if (error == nil) {
                let loginResult: FBSDKLoginManagerLoginResult = result!
                
                if (result?.isCancelled)! {
                    return
                }
                
                if (loginResult.grantedPermissions.contains("email")) {
                    self.getFacebookUserData()
                }
            }
            
        })
    }
    
    /**
     Retrieve user data from a Facebook user.
     
     - Version: 1.0
     - Author: Leo Oliveira
     */
    func getFacebookUserData() {
        if (FBSDKAccessToken.current() != nil) {
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil) {
//                    print(FBSDKProfile.current().userID)
//                    print(FBSDKProfile.current().name)
                    let dictResult = result as! NSDictionary
                    print(dictResult["email"])
                    print(dictResult["id"])
                    print(dictResult["name"])
                }
            })
        }
    }
    
    /**
     Function to dismiss view upon being triggered.
     
     - Version: 1.0
     - Author: Leo Oliveira
     */
    @objc func dismissView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    /**
     Move to the Forgot Password section of the app upon being triggered.
     
     - Version: 1.0
     - Author: Leo Oliveira
     */
    @objc func forgotPassSegue() {
        self.navigationController?.pushViewController(ForgotPassViewController(), animated: true)
    }
}

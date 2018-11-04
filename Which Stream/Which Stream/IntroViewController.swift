//
//  ViewController.swift
//  Which Stream
//
//  Created by Andrés Beltré on 7/22/18.
//  Copyright © 2018 Which. All rights reserved.
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
class IntroViewController: UIViewController {
    
    let APP_DEFAULTS = AppDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide navigation bar
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.view = APP_DEFAULTS.setupBackgroundGradientFor(view: self.view)
        // Animate the logo
        animateIntro()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    /**
     Add animation features to the view.
     
     - Version: 1.0
     - Author: Leo Oliveira
     */
    func animateIntro() {
        // Create image views for both the logo and the loading indicator
        let whichLogo = UIImageView(frame: CGRect(x: (self.view.frame.width/2 - 150), y: 80, width: 300, height: 150))
        let exclamationMark = UIImageView(frame: CGRect(x: (self.view.frame.width/2 - 150), y: (self.view.frame.height/2 - 75), width: 300, height: 150))
        
        // Set initial alpha to zero so elements don't appear in view
        whichLogo.alpha = 0
        exclamationMark.alpha = 0
        
        // Add Logo and loading indicator to view
        self.view.addSubview(whichLogo)
        self.view.addSubview(exclamationMark)
        
        // Add the image to the respective elements
        let logoImage = UIImage(named: "WhichLogo")
        whichLogo.image = logoImage
        whichLogo.contentMode = .scaleAspectFit
        
        let exclamationImage = UIImage(named: "ExclamationMark")
        exclamationMark.image = exclamationImage
        exclamationMark.contentMode = .scaleAspectFit
        
        // Animate the exclamation mark to repeatedly fade in and out
        UIView.animate(withDuration: 1.2, delay: 0.0, options: [.repeat, .autoreverse], animations: {
            exclamationMark.alpha = 1
        }, completion: nil)
        // Animate the movement of the exclamation mark to the top part of the view
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            UIView.animate(withDuration: 2.0, animations: {
                // removes the ongoing animation on the element
                exclamationMark.layer.removeAllAnimations()
                exclamationMark.alpha = 1
                exclamationMark.frame.origin.y -= 180
            }, completion: { finished in
                // Upon completion, animate showing up of Wh!ch Logo
                UIView.animate(withDuration: 1.5, animations: {
                    whichLogo.alpha = 1
                    exclamationMark.alpha = 0
                    self.setupLayout()
                })
            })
        })
    }
    
    /**
     Sets up the view's elements
     
     - Version: 1.0
     - Author: Leo Oliveira
     */
    func setupLayout() {
        // Programatically create buttons
        let loginButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 20))
        loginButton.titleLabel?.textColor = .white
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        loginButton.addTarget(self, action: #selector(loginSegue), for: .touchUpInside)
        let registerButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 20))
        registerButton.titleLabel?.textColor = .white
        registerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        registerButton.addTarget(self, action: #selector(registerSegue), for: .touchUpInside)
        let guestButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 20))
        guestButton.titleLabel?.textColor = .white
        guestButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20) 
        guestButton.addTarget(self, action: #selector(guestSegue), for: .touchUpInside)
        
        // Assign correct text to respective buttons
        loginButton.setTitle("Login", for: .normal)
        registerButton.setTitle("Register", for: .normal)
        guestButton.setTitle("Guest", for: .normal)
        
        // Initially hide buttons from view
        loginButton.isHidden = true
        registerButton.isHidden = true
        guestButton.isHidden = true
        loginButton.alpha = 0
        registerButton.alpha = 0
        guestButton.alpha = 0
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
        
        // Animate fade in of buttons in view
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            UIView.animate(withDuration: 1.5, animations: {
                loginButton.isHidden = false
                registerButton.isHidden = false
                guestButton.isHidden = false
                loginButton.alpha = 1
                registerButton.alpha = 1
                guestButton.alpha = 1
            })
        })
    }
    

    /**
     Move to the login section of the application.
     
     - Version: 1.0
     - Author: Leo Oliveira
     */
    @objc func loginSegue() {
        self.navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    /**
     Move to the register section of the application.
     
     - Version: 1.0
     - Author: Leo Oliveira
     */
    @objc func registerSegue() {
        self.navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
    /**
     Moves to the main view of the application if we have a guest user.
     
     - Version: 1.0
     - Author: Leo Oliveira
     */
    @objc func guestSegue() {

    }
    
}


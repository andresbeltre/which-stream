//
//  TermsViewController.swift
//  Which Stream
//
//  Created by Leo Oliveira on 6/23/19.
//  Copyright © 2019 Whcih. All rights reserved.
//

import UIKit

class TermsViewController: UIViewController {

    var APP_DEFAULTS: AppDefaults!
    /// Container to hold view and allow for synchronized movement with menu
    var viewContainer: UIView!
    /// Button to trigger/untrigger side menu
    var sideMenuButton: UIButton!
    /// Side menu to display extra information
    var sideMenu: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ---------- Initialize properties of current view ---------- \\
        APP_DEFAULTS = AppDefaults(viewController: self, currentVC: TERMS_VC)
        self.setupLayout()
    }
    
    /**
     Sets up the view's elements
     
     - Version: 1.0
     - Author: Leo Oliveira
     */
    func setupLayout() {
        // Instantiate view elements
        self.viewContainer = APP_DEFAULTS.setupViewContainerFor(viewController: self)
        _ = self.APP_DEFAULTS.setupSideMenuFor(viewController: self)
        self.sideMenuButton = self.APP_DEFAULTS.sideMenuButton
        
        let blur = UIBlurEffect(style: .extraLight)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.alpha = 0.4
        blurView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 75)
        
        let viewName = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width-30, height: 75))
        viewName.text = "Terms of Service"
        viewName.font = UIFont.systemFont(ofSize: 40)
        viewName.textColor = .white
        viewName.textAlignment = .left
        
        // Add elements as subviews
        self.viewContainer.addSubview(viewName)
        self.viewContainer.addSubview(blurView)
        self.view.bringSubview(toFront: self.sideMenuButton)
        self.viewContainer.bringSubview(toFront: viewName)
        
        // Add constraints
        blurView.translatesAutoresizingMaskIntoConstraints = false
        viewName.translatesAutoresizingMaskIntoConstraints = false
        
        blurView.leftAnchor.constraint(equalTo: self.viewContainer.leftAnchor).isActive = true
        blurView.rightAnchor.constraint(equalTo: self.viewContainer.rightAnchor).isActive = true
        blurView.topAnchor.constraint(equalTo: self.viewContainer.topAnchor).isActive = true
        blurView.heightAnchor.constraint(equalToConstant: UIApplication.shared.statusBarFrame.height+45).isActive = true
        
        viewName.leftAnchor.constraint(equalTo: blurView.leftAnchor, constant: 15).isActive = true
        viewName.rightAnchor.constraint(equalTo: blurView.rightAnchor, constant: -15).isActive = true
        viewName.bottomAnchor.constraint(equalTo: blurView.bottomAnchor, constant: -10).isActive = true
        viewName.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
}

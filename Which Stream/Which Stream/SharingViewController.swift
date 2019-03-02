//
//  SharingViewController.swift
//  Which Stream
//
//  Created by Leo Oliveira on 2/10/19.
//  Copyright © 2019 Whcih. All rights reserved.
//

import UIKit

class SharingViewController: UIViewController {
    var APP_DEFAULTS: AppDefaults!
    /// Container to hold view and allow for synchronized movement with menu
    var viewContainer: UIView!
    /// Button to trigger/untrigger side menu
    var sideMenuButton: UIButton!
    /// Side menu to display extra information
    var sideMenu: UIView!
    /// Random tv show background image to display in view
    var backgroundImg: UIImageView!
    /// Button to trigger sharing event
    var sharingBtn: UIButton!
    /// Social network to share on
    var socNetLbl: UILabel!
    /// Button to move on to next social network option when triggered
    var nextBtn: UIButton!
    /// Button to move on to previous social network option when triggered
    var prevBtn: UIButton!
    /// Social networks to share information with
    var socialNets = ["Twitter", "Facebook", "Instagram", "Snapchat"]
    /// Index of current social network in socialNets array
    var socialIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ---------- Initialize properties of current view ---------- \\
        APP_DEFAULTS = AppDefaults(viewController: self, currentVC: SHARING_VC)
        self.setupLayout()
    }
    
    
    func setupLayout() {
        // Instantiate view elements
        self.viewContainer = APP_DEFAULTS.setupViewContainerFor(viewController: self)
        self.sideMenu = self.APP_DEFAULTS.setupSideMenuFor(viewController: self)
        self.sideMenuButton = self.APP_DEFAULTS.sideMenuButton
        
        self.backgroundImg = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        self.backgroundImg.center.x = self.viewContainer.center.x
        self.backgroundImg.center.y = self.viewContainer.center.y
        
        self.sharingBtn = UIButton(type: .system)
        self.sharingBtn.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        self.sharingBtn.center.x = self.viewContainer.center.x
        self.sharingBtn.center.y = self.viewContainer.center.y
        self.sharingBtn.setImage(UIImage(named: "GenLogoIcon"), for: .normal)
        self.sharingBtn.tintColor = .white
        self.sharingBtn.contentMode = .scaleAspectFit

        self.socNetLbl = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        self.socNetLbl.text = self.socialNets[self.socialIndex]
        self.socNetLbl.textAlignment = .center
        self.socNetLbl.textColor = .white
        self.socNetLbl.font = UIFont.systemFont(ofSize: 18)
        
        self.nextBtn = UIButton(type: .system)
        self.nextBtn.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        self.nextBtn.setImage(UIImage(named: "RightArrowhead"), for: .normal)
        self.nextBtn.tintColor = .white
        self.nextBtn.contentMode = .scaleAspectFit
        self.nextBtn.addTarget(self, action: #selector(onNext), for: .touchUpInside)
        
        self.prevBtn = UIButton(type: .system)
        self.prevBtn.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        self.prevBtn.setImage(UIImage(named: "LeftArrowhead"), for: .normal)
        self.prevBtn.tintColor = .white
        self.prevBtn.contentMode = .scaleAspectFit
        self.prevBtn.addTarget(self, action: #selector(onPrevious), for: .touchUpInside)

        
        let viewLbl = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 30))
        viewLbl.text = "Which Sharing"
        viewLbl.textAlignment = .center
        viewLbl.textColor = .white
        viewLbl.font = UIFont.systemFont(ofSize: 18)
        
        // Add elements as subviews
        self.viewContainer.addSubview(self.backgroundImg)
        self.viewContainer.addSubview(self.sharingBtn)
        self.viewContainer.addSubview(self.nextBtn)
        self.viewContainer.addSubview(self.prevBtn)
        self.viewContainer.addSubview(self.socNetLbl)
        self.viewContainer.addSubview(viewLbl)
        self.view.bringSubview(toFront: self.sideMenuButton)
        
        // Add constraints
        self.socNetLbl.translatesAutoresizingMaskIntoConstraints = false
        self.nextBtn.translatesAutoresizingMaskIntoConstraints = false
        self.prevBtn.translatesAutoresizingMaskIntoConstraints = false
        viewLbl.translatesAutoresizingMaskIntoConstraints = false
        
        self.socNetLbl.centerXAnchor.constraint(equalTo: self.viewContainer.centerXAnchor).isActive = true
        self.socNetLbl.widthAnchor.constraint(equalToConstant: 150).isActive = true
        self.socNetLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.socNetLbl.bottomAnchor.constraint(equalTo: self.sharingBtn.topAnchor, constant: -45).isActive = true
        
        self.nextBtn.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.nextBtn.widthAnchor.constraint(equalToConstant: 20).isActive = true
        self.nextBtn.leftAnchor.constraint(equalTo: self.socNetLbl.rightAnchor, constant: 20).isActive = true
        self.nextBtn.bottomAnchor.constraint(equalTo: self.sharingBtn.topAnchor, constant: -50).isActive = true
        
        self.prevBtn.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.prevBtn.widthAnchor.constraint(equalToConstant: 20).isActive = true
        self.prevBtn.rightAnchor.constraint(equalTo: self.socNetLbl.leftAnchor, constant: -20).isActive = true
        self.prevBtn.bottomAnchor.constraint(equalTo: self.sharingBtn.topAnchor, constant: -50).isActive = true
        
        viewLbl.centerXAnchor.constraint(equalTo: self.viewContainer.centerXAnchor).isActive = true
        viewLbl.widthAnchor.constraint(equalToConstant: 150).isActive = true
        viewLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        viewLbl.bottomAnchor.constraint(equalTo: self.socNetLbl.topAnchor, constant: -10).isActive = true
    }
    
    @objc func onNext() {
        if (self.socialIndex == self.socialNets.count - 1) {
            self.socialIndex = 0
            self.socNetLbl.text = self.socialNets[self.socialIndex]
        } else {
            self.socialIndex += 1
            self.socNetLbl.text = self.socialNets[self.socialIndex]
        }
    }
    
    @objc func onPrevious() {
        if (self.socialIndex == 0) {
            self.socialIndex = self.socialNets.count - 1
            self.socNetLbl.text = self.socialNets[self.socialIndex]
        } else {
            self.socialIndex -= 1
            self.socNetLbl.text = self.socialNets[self.socialIndex]
        }
    }
}

//
//  DiscoverViewController.swift
//  Which Stream
//
//  Created by Leo Oliveira on 3/3/19.
//  Copyright © 2019 Whcih. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController {
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
    /// The discovery type chosen
    var discTypeLbl: UILabel!
    /// The discovery option chosen
    var discOptLbl: UILabel!
    /// Button to move on to next discovery type when triggered
    var nextDiscTypeBtn: UIButton!
    /// Button to move on to the next discovery option when triggered
    var nextDiscOptBtn: UIButton!
    /// Button to move on to previous discovery type option when triggered
    var prevDiscTypeBtn: UIButton!
    /// Button to move on to previous discovery option when triggered
    var prevDiscOptBtn: UIButton!
    /// Discovery types
    var discTypes = ["Discover", "Current Show"]
    /// Discovery options
    var discOptions = ["Movie", "Series", "Cartoon", "Anime"]
    
    /// Index of current type in discoveryTypes array
    var discTypeIndex = 0
    /// Index of current option in discoveryOptions array
    var discOptIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ---------- Initialize properties of current view ---------- \\
        APP_DEFAULTS = AppDefaults(viewController: self, currentVC: DISCOVER_VC)
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
        
        self.discTypeLbl = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        self.discTypeLbl.text = self.discTypes[self.discTypeIndex]
        self.discTypeLbl.textAlignment = .center
        self.discTypeLbl.textColor = .white
        self.discTypeLbl.font = UIFont.systemFont(ofSize: 18)
        
        self.discOptLbl = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        self.discOptLbl.text = self.discOptions[self.discOptIndex]
        self.discOptLbl.textAlignment = .center
        self.discOptLbl.textColor = .white
        self.discOptLbl.font = UIFont.systemFont(ofSize: 18)
        
        self.nextDiscTypeBtn = UIButton(type: .system)
        self.nextDiscTypeBtn.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        self.nextDiscTypeBtn.setImage(UIImage(named: "RightArrowhead"), for: .normal)
        self.nextDiscTypeBtn.tintColor = .white
        self.nextDiscTypeBtn.contentMode = .scaleAspectFit
        self.nextDiscTypeBtn.addTarget(self, action: #selector(onNextDiscType), for: .touchUpInside)
        
        self.nextDiscOptBtn = UIButton(type: .system)
        self.nextDiscOptBtn.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        self.nextDiscOptBtn.setImage(UIImage(named: "RightArrowhead"), for: .normal)
        self.nextDiscOptBtn.tintColor = .white
        self.nextDiscOptBtn.contentMode = .scaleAspectFit
        self.nextDiscOptBtn.addTarget(self, action: #selector(onNextDiscOpt), for: .touchUpInside)
        
        self.prevDiscTypeBtn = UIButton(type: .system)
        self.prevDiscTypeBtn.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        self.prevDiscTypeBtn.setImage(UIImage(named: "LeftArrowhead"), for: .normal)
        self.prevDiscTypeBtn.tintColor = .white
        self.prevDiscTypeBtn.contentMode = .scaleAspectFit
        self.prevDiscTypeBtn.addTarget(self, action: #selector(onPreviousDiscType), for: .touchUpInside)
        
        self.prevDiscOptBtn = UIButton(type: .system)
        self.prevDiscOptBtn.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        self.prevDiscOptBtn.setImage(UIImage(named: "LeftArrowhead"), for: .normal)
        self.prevDiscOptBtn.tintColor = .white
        self.prevDiscOptBtn.contentMode = .scaleAspectFit
        self.prevDiscOptBtn.addTarget(self, action: #selector(onPreviousDiscOpt), for: .touchUpInside)
        
        // Add elements as subviews
        self.viewContainer.addSubview(self.backgroundImg)
        self.viewContainer.addSubview(self.sharingBtn)
        self.viewContainer.addSubview(self.nextDiscTypeBtn)
        self.viewContainer.addSubview(self.nextDiscOptBtn)
        self.viewContainer.addSubview(self.prevDiscTypeBtn)
        self.viewContainer.addSubview(self.prevDiscOptBtn)
        self.viewContainer.addSubview(self.discTypeLbl)
        self.viewContainer.addSubview(self.discOptLbl)
        self.view.bringSubview(toFront: self.sideMenuButton)
        
        // Add constraints
        self.discTypeLbl.translatesAutoresizingMaskIntoConstraints = false
        self.discOptLbl.translatesAutoresizingMaskIntoConstraints = false
        self.nextDiscTypeBtn.translatesAutoresizingMaskIntoConstraints = false
        self.nextDiscOptBtn.translatesAutoresizingMaskIntoConstraints = false
        self.prevDiscTypeBtn.translatesAutoresizingMaskIntoConstraints = false
        self.prevDiscOptBtn.translatesAutoresizingMaskIntoConstraints = false
        
        self.discOptLbl.centerXAnchor.constraint(equalTo: self.viewContainer.centerXAnchor).isActive = true
        self.discOptLbl.widthAnchor.constraint(equalToConstant: 150).isActive = true
        self.discOptLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.discOptLbl.bottomAnchor.constraint(equalTo: self.sharingBtn.topAnchor, constant: -45).isActive = true
        
        self.discTypeLbl.centerXAnchor.constraint(equalTo: self.viewContainer.centerXAnchor).isActive = true
        self.discTypeLbl.widthAnchor.constraint(equalToConstant: 150).isActive = true
        self.discTypeLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.discTypeLbl.bottomAnchor.constraint(equalTo: self.discOptLbl.topAnchor, constant: -10).isActive = true
        
        self.nextDiscOptBtn.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.nextDiscOptBtn.widthAnchor.constraint(equalToConstant: 20).isActive = true
        self.nextDiscOptBtn.leftAnchor.constraint(equalTo: self.discOptLbl.rightAnchor, constant: 20).isActive = true
        self.nextDiscOptBtn.bottomAnchor.constraint(equalTo: self.sharingBtn.topAnchor, constant: -50).isActive = true
        
        self.prevDiscOptBtn.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.prevDiscOptBtn.widthAnchor.constraint(equalToConstant: 20).isActive = true
        self.prevDiscOptBtn.rightAnchor.constraint(equalTo: self.discOptLbl.leftAnchor, constant: -20).isActive = true
        self.prevDiscOptBtn.bottomAnchor.constraint(equalTo: self.sharingBtn.topAnchor, constant: -50).isActive = true
        
        self.nextDiscTypeBtn.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.nextDiscTypeBtn.widthAnchor.constraint(equalToConstant: 20).isActive = true
        self.nextDiscTypeBtn.leftAnchor.constraint(equalTo: self.discTypeLbl.rightAnchor, constant: 20).isActive = true
        self.nextDiscTypeBtn.bottomAnchor.constraint(equalTo: self.discOptLbl.topAnchor, constant: -15).isActive = true
        
        self.prevDiscTypeBtn.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.prevDiscTypeBtn.widthAnchor.constraint(equalToConstant: 20).isActive = true
        self.prevDiscTypeBtn.rightAnchor.constraint(equalTo: self.discTypeLbl.leftAnchor, constant: -20).isActive = true
        self.prevDiscTypeBtn.bottomAnchor.constraint(equalTo: self.discOptLbl.topAnchor, constant: -15).isActive = true
    }
    
    @objc func onNextDiscOpt() {
        if (self.discOptIndex == self.discOptions.count - 1) {
            self.discOptIndex = 0
            self.discOptLbl.text = self.discOptions[self.discOptIndex]
        } else {
            self.discOptIndex += 1
            self.discOptLbl.text = self.discOptions[self.discOptIndex]
        }
    }
    
    @objc func onPreviousDiscOpt() {
        if (self.discOptIndex == 0) {
            self.discOptIndex = self.discOptions.count - 1
            self.discOptLbl.text = self.discOptions[self.discOptIndex]
        } else {
            self.discOptIndex -= 1
            self.discOptLbl.text = self.discOptions[self.discOptIndex]
        }
    }
    
    @objc func onNextDiscType() {
        if (self.discTypeIndex == self.discTypes.count - 1) {
            self.discTypeIndex = 0
            self.discTypeLbl.text = self.discTypes[self.discTypeIndex]
        } else {
            self.discTypeIndex += 1
            self.discTypeLbl.text = self.discTypes[self.discTypeIndex]
        }
    }
    
    @objc func onPreviousDiscType() {
        if (self.discTypeIndex == 0) {
            self.discTypeIndex = self.discTypes.count - 1
            self.discTypeLbl.text = self.discTypes[self.discTypeIndex]
        } else {
            self.discTypeIndex -= 1
            self.discTypeLbl.text = self.discTypes[self.discTypeIndex]
        }
    }
}

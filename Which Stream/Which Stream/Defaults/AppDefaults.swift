//
//  AppDefaults.swift
//  Which Stream
//
//  Created by Leo Oliveira on 11/4/18.
//  Copyright © 2018 Which. All rights reserved.
//

import UIKit

let MAIN_VC = "MAIN_VC"
let SHARING_VC = "SHARING_VC"

class AppDefaults {
    var sideMenuLeftAnchorConstraint: NSLayoutConstraint!
    var sideMenuButtonRightAnchorConstraint: NSLayoutConstraint!
    var dismissMenuGesture: UITapGestureRecognizer! // NOT USED BUT NEEDED TO CONFORM TO PROTOCOL
    var MAX_X: CGFloat!
    
    /// String name representation of current VC for identification purposes
    var currentVC = ""
    /// Variable to allow handling of app navigation through App Defulats
    var navigationController: UINavigationController!
    /// Side menu to display extra information
    var sideMenu: UIView!
    /// Button to trigger/untrigger side menu
    var sideMenuButton: UIButton!
    
    init() {
        // Empty initializer
    }
    
    init(viewController: UIViewController?, currentVC: String) {
        // Special initializer for classes containing the side menu.
        // Must pass identifier for VC (see keys above class)
        self.currentVC = currentVC
        self.navigationController = viewController?.navigationController!
        self.MAX_X = viewController?.view.frame.maxX
        
        self.sideMenuButton = UIButton(type: .system)
        self.sideMenuButton.setTitle("\u{2261}", for: .normal)
        self.sideMenuButton.titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        self.sideMenuButton.setTitleColor(.white, for: .normal)
        self.sideMenuButton.addTarget(self, action: #selector(triggerMenu), for: .touchUpInside)
        
        viewController!.view.addSubview(self.sideMenuButton)
        
        self.sideMenuButton.translatesAutoresizingMaskIntoConstraints = false
        self.sideMenuButton.topAnchor.constraint(equalTo: viewController!.view.topAnchor, constant: 45).isActive = true
        self.sideMenuButtonRightAnchorConstraint = self.sideMenuButton.rightAnchor.constraint(equalTo: viewController!.view.rightAnchor, constant: -10)
        self.sideMenuButtonRightAnchorConstraint.isActive = true
        self.sideMenuButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        self.sideMenuButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
        
    }
    
    /**
     Custom actions upon being triggered by side menu button.
     
     - Version: 1.0
     - Author: Leo Oliveira
     */
    @objc func triggerMenu() {
        UIView.animate(withDuration: 0.75, animations: {
            if (self.sideMenu.center.x > self.MAX_X) {
                self.sideMenuLeftAnchorConstraint.isActive = false
                self.sideMenuButtonRightAnchorConstraint.isActive = false
                self.sideMenu.center.x -= 200
                self.sideMenuButton.center.x -= 130
                self.sideMenuButton.setTitle("x", for: .normal)
                self.sideMenuButton.setTitleColor(.black, for: .normal)
                self.sideMenuLeftAnchorConstraint.constant = -200
                self.sideMenuButtonRightAnchorConstraint.constant -= 130
                self.sideMenuLeftAnchorConstraint.isActive = true
                self.sideMenuButtonRightAnchorConstraint.isActive = true
            } else {
                self.dismissMenuIfVisible()
            }
        })
    }
    
    @objc func dismissMenuIfVisible() {
        UIView.animate(withDuration: 0.75, animations: {
            if (self.sideMenu.center.x < self.MAX_X) {
                self.dismissMenuGesture.cancelsTouchesInView = true
                self.sideMenuLeftAnchorConstraint.isActive = false
                self.sideMenuButtonRightAnchorConstraint.isActive = false
                self.sideMenu.center.x += 200
                self.sideMenuButton.center.x += 130
                self.sideMenuButton.setTitle("\u{2261}", for: .normal)
                self.sideMenuButton.setTitleColor(.white, for: .normal)
                self.sideMenuLeftAnchorConstraint.constant = 0
                self.sideMenuButtonRightAnchorConstraint.constant = -10
                self.sideMenuLeftAnchorConstraint.isActive = true
                self.sideMenuButtonRightAnchorConstraint.isActive = true
            } else {
                self.dismissMenuGesture.cancelsTouchesInView = false
            }
        })
    }
    
    /**
     Creates a color gradient and sets it as the background
     
     - Version: 1.0
     - Author: Leo Oliveira
     */
    func setupBackgroundGradientFor(view: UIView) -> UIView {
        view.backgroundColor = .clear
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        gradientLayer.colors = [UIColor(hex: "5d0028").cgColor, UIColor(hex: "c96548").cgColor]
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        return view
    }
    
    func setupViewContainerFor(viewController: UIViewController?) -> UIView {
        viewController!.view = setupBackgroundGradientFor(view: viewController!.view)
        var viewContainer = UIView(frame: CGRect(x: 0, y: 0, width: viewController!.view.frame.width, height: viewController!.view.frame.height))
        viewContainer.center.x = viewController!.view.center.x
        viewContainer.center.y = viewController!.view.center.y
        viewContainer = setupBackgroundGradientFor(view: viewContainer)
        self.dismissMenuGesture = UITapGestureRecognizer(target: self, action: #selector(dismissMenuIfVisible))
        self.dismissMenuGesture.cancelsTouchesInView = true
        viewContainer.addGestureRecognizer(self.dismissMenuGesture)
        
        viewController!.view.addSubview(viewContainer)
        
        return viewContainer
    }
    
    func setupSideMenuFor(viewController: UIViewController?) -> UIView {
        var profileBtn, feedBtn, sharingBtn, discoverBtn, queueBtn, searchBtn: UIButton!
        var supportBtn, legalBtn, termsBtn, privacyBtn, notificationsBtn, logoutBtn: UIButton!
        self.sideMenu = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: viewController!.view.frame.height))
        self.sideMenu.backgroundColor = .white
        self.sideMenu.alpha = 0.70
        
        profileBtn = createMenuButton(in: self.sideMenu, withTitle: "Your Profile", forNavigateToPage: "PROFILE")
        feedBtn = createMenuButton(in: self.sideMenu, withTitle: "Friends Feed", forNavigateToPage: "FEED")
        sharingBtn = createMenuButton(in: self.sideMenu, withTitle: "Which Sharing", forNavigateToPage: "SHARING")
        discoverBtn = createMenuButton(in: self.sideMenu, withTitle: "Discover", forNavigateToPage: "DISCOVER")
        queueBtn = createMenuButton(in: self.sideMenu, withTitle: "Your Queue", forNavigateToPage: "QUEUE")
        searchBtn = createMenuButton(in: self.sideMenu, withTitle: "Search", forNavigateToPage: "SEARCH")
        supportBtn = createMenuButton(in: self.sideMenu, withTitle: "Support", forNavigateToPage: "SUPPORT")
        legalBtn = createMenuButton(in: self.sideMenu, withTitle: "Legal", forNavigateToPage: "LEGAL")
        termsBtn = createMenuButton(in: self.sideMenu, withTitle: "Terms of Service", forNavigateToPage: "TERMS")
        privacyBtn = createMenuButton(in: self.sideMenu, withTitle: "Privacy Policy", forNavigateToPage: "PRIVACY")
        notificationsBtn = createMenuButton(in: self.sideMenu, withTitle: "Notifications", forNavigateToPage: "NOTIFICATIONS")
        logoutBtn = createMenuButton(in: self.sideMenu, withTitle: "Logout", forNavigateToPage: "LOGOUT")
        
        self.sideMenu.addSubview(profileBtn)
        self.sideMenu.addSubview(feedBtn)
        self.sideMenu.addSubview(sharingBtn)
        self.sideMenu.addSubview(discoverBtn)
        self.sideMenu.addSubview(queueBtn)
        self.sideMenu.addSubview(searchBtn)
        self.sideMenu.addSubview(supportBtn)
        self.sideMenu.addSubview(legalBtn)
        self.sideMenu.addSubview(termsBtn)
        self.sideMenu.addSubview(privacyBtn)
        self.sideMenu.addSubview(notificationsBtn)
        self.sideMenu.addSubview(logoutBtn)
        
        // Add sideMenu as subview
        viewController!.view.addSubview(self.sideMenu)
        
        // Add sideMenu constraints
        self.sideMenu.translatesAutoresizingMaskIntoConstraints = false
        
        self.sideMenu.topAnchor.constraint(equalTo: viewController!.view.topAnchor).isActive = true
        self.sideMenu.bottomAnchor.constraint(equalTo: viewController!.view.bottomAnchor).isActive = true
        self.sideMenu.heightAnchor.constraint(equalToConstant: viewController!.view.frame.height).isActive = true
        self.sideMenu.widthAnchor.constraint(equalToConstant: 200).isActive = true
        self.sideMenuLeftAnchorConstraint = self.sideMenu.leftAnchor.constraint(equalTo: viewController!.view.rightAnchor)
        self.sideMenuLeftAnchorConstraint.isActive = true
        
        return self.sideMenu
    }
    
    @objc func toProfileVC() {
        
    }
    
    @objc func toFeedVC(navigationController: UINavigationController) {
        if (self.currentVC != MAIN_VC) {
            self.isInStack(newVC: MAIN_VC)
            self.navigationController.pushViewController(MainViewController(), animated: true)
        } else {
            self.dismissMenuIfVisible()
        }
    }
    
    @objc func toSharingVC() {
        if (self.currentVC != SHARING_VC) {
            self.isInStack(newVC: SHARING_VC)
            self.navigationController.pushViewController(SharingViewController(), animated: true)
        } else {
            self.dismissMenuIfVisible()
        }
    }
    
    @objc func toDiscoverVC() {
        
    }
    
    @objc func toQueueVC() {
        
    }
    
    @objc func toSearchVC() {
        
    }
    
    @objc func toSupportVC() {
        
    }
    
    @objc func toLegalVC() {
        
    }
    
    @objc func toTermsVC() {
        
    }
    
    @objc func toPrivacyVC() {
        
    }
    
    @objc func toNotificationsVC() {
        
    }
    
    @objc func toLogoutVC() {
        
    }
    
    fileprivate func isInStack(newVC: String) {
        switch newVC {
            case MAIN_VC:
                removeFromStack(kind: MainViewController.self)
            case SHARING_VC:
                removeFromStack(kind: SharingViewController.self)
            default:
                break
        }
    }
    
    fileprivate func removeFromStack(kind: AnyClass) {
        var index = 0
        var viewControllers = self.navigationController.viewControllers
        for viewController in self.navigationController.viewControllers {
            if (viewController.isKind(of: kind)) {
                viewControllers.remove(at: index)
                self.navigationController.viewControllers = viewControllers
                break
            }
            index += 1
        }
    }
    
    fileprivate func createMenuButton(in view: UIView, withTitle title: String, forNavigateToPage page: String) -> UIButton {
        let btn = UIButton(type: .system)
        let leftSideSpacing = 15
        let width = Int(view.frame.width - 30)
        let height = 25
        
        switch page {
            case "PROFILE":
                btn.frame = CGRect(x: leftSideSpacing, y: 100, width: width, height: height)
                btn.addTarget(self, action: #selector(toProfileVC), for: .touchUpInside)
            case "FEED":
                btn.frame = CGRect(x: leftSideSpacing, y: 140, width: width, height: height)
                btn.addTarget(self, action: #selector(toFeedVC), for: .touchUpInside)
            case "SHARING":
                btn.frame = CGRect(x: leftSideSpacing, y: 180, width: width, height: height)
                btn.addTarget(self, action: #selector(toSharingVC), for: .touchUpInside)
            case "DISCOVER":
                btn.frame = CGRect(x: leftSideSpacing, y: 220, width: width, height: height)
                btn.addTarget(self, action: #selector(toDiscoverVC), for: .touchUpInside)
            case "QUEUE":
                btn.frame = CGRect(x: leftSideSpacing, y: 260, width: width, height: height)
                btn.addTarget(self, action: #selector(toQueueVC), for: .touchUpInside)
            case "SEARCH":
                btn.frame = CGRect(x: leftSideSpacing, y: 300, width: width, height: height)
                btn.addTarget(self, action: #selector(toSearchVC), for: .touchUpInside)
            case "SUPPORT":
                btn.frame = CGRect(x: leftSideSpacing, y: 380, width: width, height: height)
                btn.addTarget(self, action: #selector(toSupportVC), for: .touchUpInside)
            case "LEGAL":
                btn.frame = CGRect(x: leftSideSpacing, y: 420, width: width, height: height)
                btn.addTarget(self, action: #selector(toLegalVC), for: .touchUpInside)
            case "TERMS":
                btn.frame = CGRect(x: leftSideSpacing, y: 460, width: width, height: height)
                btn.addTarget(self, action: #selector(toTermsVC), for: .touchUpInside)
            case "PRIVACY":
                btn.frame = CGRect(x: leftSideSpacing, y: 500, width: width, height: height)
                btn.addTarget(self, action: #selector(toPrivacyVC), for: .touchUpInside)
            case "NOTIFICATIONS":
                btn.frame = CGRect(x: leftSideSpacing, y: 540, width: width, height: height)
                btn.addTarget(self, action: #selector(toNotificationsVC), for: .touchUpInside)
            case "LOGOUT":
                btn.frame = CGRect(x: leftSideSpacing, y: 580, width: width, height: height)
                btn.addTarget(self, action: #selector(toLogoutVC), for: .touchUpInside)
            default:
                break
        }
        
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        btn.contentHorizontalAlignment = .left
        return btn
    }
}

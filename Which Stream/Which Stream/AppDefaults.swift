//
//  AppDefaults.swift
//  Which Stream
//
//  Created by Leo Oliveira on 11/4/18.
//  Copyright © 2018 Which. All rights reserved.
//

import UIKit

class AppDefaults {
    
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
    
    func setupSideMenuFor(view: UIView) -> UIView {
        var profileBtn, feedBtn, sharingBtn, discoverBtn, queueBtn, searchBtn: UIButton!
        var supportBtn, legalBtn, termsBtn, privacyBtn, notificationsBtn, logoutBtn: UIButton!
        view.backgroundColor = .white
        view.alpha = 0.70
        
        profileBtn = createMenuButton(in: view, withTitle: "Your Profile", forNavigateToPage: "PROFILE")
        feedBtn = createMenuButton(in: view, withTitle: "Friends Feed", forNavigateToPage: "FEED")
        sharingBtn = createMenuButton(in: view, withTitle: "Which Sharing", forNavigateToPage: "SHARING")
        discoverBtn = createMenuButton(in: view, withTitle: "Discover", forNavigateToPage: "DISCOVER")
        queueBtn = createMenuButton(in: view, withTitle: "Your Queue", forNavigateToPage: "QUEUE")
        searchBtn = createMenuButton(in: view, withTitle: "Search", forNavigateToPage: "SEARCH")
        supportBtn = createMenuButton(in: view, withTitle: "Support", forNavigateToPage: "SUPPORT")
        legalBtn = createMenuButton(in: view, withTitle: "Legal", forNavigateToPage: "LEGAL")
        termsBtn = createMenuButton(in: view, withTitle: "Terms of Service", forNavigateToPage: "TERMS")
        privacyBtn = createMenuButton(in: view, withTitle: "Privacy Policy", forNavigateToPage: "PRIVACY")
        notificationsBtn = createMenuButton(in: view, withTitle: "Notifications", forNavigateToPage: "NOTIFICATIONS")
        logoutBtn = createMenuButton(in: view, withTitle: "Logout", forNavigateToPage: "LOGOUT")
        
        view.addSubview(profileBtn)
        view.addSubview(feedBtn)
        view.addSubview(sharingBtn)
        view.addSubview(discoverBtn)
        view.addSubview(queueBtn)
        view.addSubview(searchBtn)
        view.addSubview(supportBtn)
        view.addSubview(legalBtn)
        view.addSubview(termsBtn)
        view.addSubview(privacyBtn)
        view.addSubview(notificationsBtn)
        view.addSubview(logoutBtn)
        
        return view
    }
    
    @objc func toProfileVC() {
        
    }
    
    @objc func toFeedVC() {
        
    }
    
    @objc func toSharingVC() {
        
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

//
//  FriendsFeedViewController.swift
//  Which Stream
//
//  Created by Leo Oliveira on 6/3/19.
//  Copyright © 2019 Whcih. All rights reserved.
//

import UIKit

class FriendsFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var APP_DEFAULTS: AppDefaults!
    
    /// Container to hold view and allow for synchronized movement with menu
    var viewContainer: UIView!
    /// Table to display tv show history
    var tableView: UITableView!
    /// Button to trigger/untrigger side menu
    var sideMenuButton: UIButton!
    /// Side menu to display extra information
    var sideMenu: UIView!
    /// Last watched show title in history
    var latestShow: UILabel!
    /// Last watched show description in history
    var latestShowDesc: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ---------- Initialize properties of current view ---------- \\
        APP_DEFAULTS = AppDefaults(viewController: self, currentVC: FRIENDS_FEED_VC)
        self.setupLayout()
    }

    /**
     Sets up the initial elements of the view.
     
     - Version: 1.0
     - Author: Leo Oliveira
     */
    func setupLayout() {
        // Instantiate view elements
        self.viewContainer = APP_DEFAULTS.setupViewContainerFor(viewController: self)
        _ = self.APP_DEFAULTS.setupSideMenuFor(viewController: self)
        self.sideMenuButton = self.APP_DEFAULTS.sideMenuButton
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .clear
        self.tableView.separatorColor = .white
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let blur = UIBlurEffect(style: .extraLight)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.alpha = 0.4
        blurView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 110)
        
        let historyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.viewContainer.frame.width - 35, height: 20))
        historyLabel.text = "History"
        historyLabel.textColor = .white
        historyLabel.font = UIFont.systemFont(ofSize: 25)
        
        let separator = UIView(frame: CGRect(x: 0, y: 0, width: self.viewContainer.frame.width - 20, height: 1))
        separator.backgroundColor = .white
        
        self.latestShow = UILabel(frame: CGRect(x: 0, y: 0, width: self.viewContainer.frame.width - 20, height: 20))
        self.latestShow.textColor = .white
        self.latestShow.font = UIFont.boldSystemFont(ofSize: 16)
        self.latestShow.text = "Safety Training, The Office"
        
        self.latestShowDesc = UILabel(frame: CGRect(x: 0, y: 0, width: self.viewContainer.frame.width - 20, height: 60))
        self.latestShowDesc.textColor = .white
        self.latestShowDesc.font = UIFont.systemFont(ofSize: 14)
        self.latestShowDesc.numberOfLines = 3
        self.latestShowDesc.text = "Safety training is one of my favorite episodes of the office starting in season 5 episode 14 and ending on episode 15. Its a two part episode and probably one of the most memorable episodes of the office"
        
        // Add elements as subviews
        self.viewContainer.addSubview(blurView)
        self.viewContainer.addSubview(historyLabel)
        self.viewContainer.addSubview(self.latestShow)
        self.viewContainer.addSubview(self.latestShowDesc)
        self.viewContainer.addSubview(separator)
        self.viewContainer.addSubview(self.tableView)
        self.viewContainer.bringSubview(toFront: historyLabel)
        self.viewContainer.bringSubview(toFront: separator)
        self.viewContainer.bringSubview(toFront: self.latestShow)
        self.viewContainer.bringSubview(toFront: self.latestShowDesc)
        self.view.bringSubview(toFront: self.sideMenuButton)
        
        blurView.translatesAutoresizingMaskIntoConstraints = false
        separator.translatesAutoresizingMaskIntoConstraints = false
        historyLabel.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.latestShow.translatesAutoresizingMaskIntoConstraints = false
        self.latestShowDesc.translatesAutoresizingMaskIntoConstraints = false
        
        blurView.leftAnchor.constraint(equalTo: self.viewContainer.leftAnchor).isActive = true
        blurView.rightAnchor.constraint(equalTo: self.viewContainer.rightAnchor).isActive = true
        blurView.topAnchor.constraint(equalTo: self.viewContainer.topAnchor).isActive = true
        blurView.heightAnchor.constraint(equalToConstant: UIApplication.shared.statusBarFrame.height+120).isActive = true
        
        historyLabel.leftAnchor.constraint(equalTo: self.viewContainer.leftAnchor, constant: 15).isActive = true
        historyLabel.rightAnchor.constraint(equalTo: self.viewContainer.rightAnchor, constant: -35).isActive = true
        historyLabel.topAnchor.constraint(equalTo: self.viewContainer.topAnchor, constant: UIApplication.shared.statusBarFrame.height + 10).isActive = true
        historyLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        separator.leftAnchor.constraint(equalTo: self.viewContainer.leftAnchor, constant: 20).isActive = true
        separator.rightAnchor.constraint(equalTo: self.viewContainer.rightAnchor, constant: -20).isActive = true
        separator.topAnchor.constraint(equalTo: historyLabel.bottomAnchor, constant: 5).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        self.latestShow.topAnchor.constraint(equalTo: separator.bottomAnchor).isActive = true
        self.latestShow.leftAnchor.constraint(equalTo: self.viewContainer.leftAnchor, constant: 20).isActive = true
        self.latestShow.rightAnchor.constraint(equalTo: self.viewContainer.rightAnchor, constant: -20).isActive = true
        
        self.latestShowDesc.topAnchor.constraint(equalTo: self.latestShow.bottomAnchor, constant: 5).isActive = true
        self.latestShowDesc.leftAnchor.constraint(equalTo: self.viewContainer.leftAnchor, constant: 20).isActive = true
        self.latestShowDesc.rightAnchor.constraint(equalTo: self.viewContainer.rightAnchor, constant: -20).isActive = true
        self.latestShowDesc.bottomAnchor.constraint(equalTo: blurView.bottomAnchor, constant: -2).isActive = true
        
        self.tableView.topAnchor.constraint(equalTo: blurView.bottomAnchor).isActive = true
        self.tableView.leftAnchor.constraint(equalTo: self.viewContainer.leftAnchor).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: self.viewContainer.rightAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.viewContainer.bottomAnchor).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.backgroundColor = .clear
     
        return cell
    }
}

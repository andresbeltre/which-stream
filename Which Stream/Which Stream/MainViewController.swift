//
//  MainViewController.swift
//  Which Stream
//
//  Created by Leo Oliveira on 9/20/18.
//  Copyright © 2018 Which. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var APP_DEFAULTS: AppDefaults!
    
    /// Container to hold view and allow for synchronized movement with menu
    var viewContainer: UIView!
    /// Table to display tv show history
    var tableView: UITableView!
    /// User profile picture
    var profile: UIImageView!
    /// User's name
    var name: UILabel!
    /// Last tv show watched by the user
    var lastWatched: UILabel!
    /// Button to trigger/untrigger side menu
    var sideMenuButton: UIButton!
    /// Side menu to display extra information
    var sideMenu: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ---------- Initialize properties of current view ---------- \\
        APP_DEFAULTS = AppDefaults(viewController: self, currentVC: MAIN_VC)
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
        
        self.profile = UIImageView(frame: CGRect(x: 0, y: 0, width: 75, height: 75))
        self.profile.backgroundColor = .blue
        self.profile.layer.cornerRadius = self.profile.frame.width/2
        self.profile.clipsToBounds = true
        
        self.name = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        self.name.text = "Firstname Lastname"
        self.name.textColor = .white
        self.name.font = UIFont.systemFont(ofSize: 22)
        
        self.lastWatched = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        self.lastWatched.text = "Last watched show"
        self.lastWatched.textColor = .white
        self.lastWatched.font = UIFont.italicSystemFont(ofSize: 18)

        let blur = UIBlurEffect(style: .extraLight)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.alpha = 0.4
        blurView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 110)

        // Add elements as subviews
        self.viewContainer.addSubview(blurView)
        self.viewContainer.addSubview(self.profile)
        self.viewContainer.addSubview(self.name)
        self.viewContainer.addSubview(self.lastWatched)
        self.viewContainer.addSubview(self.tableView)
        self.view.bringSubview(toFront: self.sideMenuButton)
        
        // Add constraints
        blurView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.profile.translatesAutoresizingMaskIntoConstraints = false
        self.name.translatesAutoresizingMaskIntoConstraints = false
        self.lastWatched.translatesAutoresizingMaskIntoConstraints = false
        
        blurView.leftAnchor.constraint(equalTo: self.viewContainer.leftAnchor).isActive = true
        blurView.rightAnchor.constraint(equalTo: self.viewContainer.rightAnchor).isActive = true
        blurView.topAnchor.constraint(equalTo: self.viewContainer.topAnchor).isActive = true
        blurView.bottomAnchor.constraint(equalTo: self.tableView.topAnchor).isActive = true
        
        self.profile.topAnchor.constraint(equalTo: self.viewContainer.topAnchor, constant: 45).isActive = true
        self.profile.leftAnchor.constraint(equalTo: self.viewContainer.leftAnchor, constant: 10).isActive = true
        self.profile.heightAnchor.constraint(equalToConstant: 75).isActive = true
        self.profile.widthAnchor.constraint(equalToConstant: 75).isActive = true
        
        self.name.centerYAnchor.constraint(equalTo: self.profile.centerYAnchor, constant: -10).isActive = true
        self.name.leftAnchor.constraint(equalTo: self.profile.rightAnchor, constant: 10).isActive = true
        self.name.rightAnchor.constraint(equalTo: self.viewContainer.rightAnchor, constant: -25).isActive = true
        self.name.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.lastWatched.leftAnchor.constraint(equalTo: self.profile.rightAnchor, constant: 10).isActive = true
        self.lastWatched.topAnchor.constraint(equalTo: self.name.bottomAnchor, constant: 5).isActive = true
        self.lastWatched.rightAnchor.constraint(equalTo: self.viewContainer.rightAnchor, constant: -25).isActive = true
        self.lastWatched.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.tableView.topAnchor.constraint(equalTo: self.profile.bottomAnchor, constant: 10).isActive = true
        self.tableView.leftAnchor.constraint(equalTo: self.viewContainer.leftAnchor).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: self.viewContainer.rightAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.viewContainer.bottomAnchor).isActive = true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0) {
            return 40
        } else {
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.backgroundColor = .clear
        
        if (indexPath.row == 0) {
            let headerCell = UITableViewCell()
            headerCell.backgroundColor = .clear
            let label = UILabel(frame: CGRect(x: 10, y: 0, width: cell.frame.width - 10, height: 40))
            label.textColor = .white
            label.text = "History"
            label.font = UIFont.systemFont(ofSize: 25)
            headerCell.addSubview(label)
            headerCell.isUserInteractionEnabled = false
            return headerCell
        } else {
            let label = UILabel(frame: CGRect(x: 100, y: 20, width: 50, height: 20))
            label.textColor = .white
            label.text = "Test"
            cell.addSubview(label)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("SELECTED")
    }
}

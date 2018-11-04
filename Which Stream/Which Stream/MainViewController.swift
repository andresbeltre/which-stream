//
//  MainViewController.swift
//  Which Stream
//
//  Created by Leo Oliveira on 9/20/18.
//  Copyright © 2018 Which. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let APP_DEFAULTS = AppDefaults()
    
    var tableView: UITableView!
    var profile: UIImageView!
    var name: UILabel!
    var lastWatched: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .purple
        self.view = APP_DEFAULTS.setupBackgroundGradientFor(view: self.view)
        setupLayout()
    }
    
    /**
     Sets up the initial elements of the view.
     
     - Version: 1.0
     - Author: Leo Oliveira
     */
    func setupLayout() {
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        self.tableView.backgroundColor = .clear
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: self.tableView.frame.height)
        
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        gradientLayer.colors = [UIColor(hex: "5d0028").cgColor, UIColor(hex: "c96548").cgColor]
        self.tableView.layer.insertSublayer(gradientLayer, at: 0)
        
        
        self.profile = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        self.profile.backgroundColor = .blue
        self.name = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        self.name.text = "Firstname Lastname"
        self.name.textColor = .white
        self.name.font = UIFont.systemFont(ofSize: 30)
        self.lastWatched = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        self.lastWatched.text = "Last watched show"
        self.lastWatched.textColor = .white
        self.lastWatched.font = UIFont.italicSystemFont(ofSize: 25)
        
        let tableHeader = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40))
        tableHeader.backgroundColor = .purple
        let tableHeaderLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40))
        tableHeaderLabel.text = "History"
        tableHeaderLabel.font = UIFont.systemFont(ofSize: 20)
        tableHeaderLabel.textColor = .white
        tableHeader.addSubview(tableHeaderLabel)
        self.tableView.tableHeaderView = tableHeader
        
        // Add elements as subviews
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.profile)
        self.view.addSubview(self.name)
        self.view.addSubview(self.lastWatched)
        
        // Add constraints
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        tableHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        self.profile.translatesAutoresizingMaskIntoConstraints = false
        self.name.translatesAutoresizingMaskIntoConstraints = false
        self.lastWatched.translatesAutoresizingMaskIntoConstraints = false
        
        self.profile.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30).isActive = true
        self.profile.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        self.profile.addConstraint(NSLayoutConstraint(item: self.profile, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100))
        self.profile.addConstraint(NSLayoutConstraint(item: self.profile, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100))
        
        self.name.centerYAnchor.constraint(equalTo: self.profile.centerYAnchor, constant: -10).isActive = true
        self.name.leftAnchor.constraint(equalTo: self.profile.rightAnchor, constant: 15).isActive = true
        self.name.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        self.name.addConstraint(NSLayoutConstraint(item: self.name, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30))
        
        self.lastWatched.leftAnchor.constraint(equalTo: self.profile.rightAnchor, constant: 15).isActive = true
        self.lastWatched.topAnchor.constraint(equalTo: self.name.bottomAnchor, constant: 5).isActive = true
        self.lastWatched.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        self.lastWatched.addConstraint(NSLayoutConstraint(item: self.lastWatched, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20))
        
        self.tableView.topAnchor.constraint(equalTo: self.profile.bottomAnchor, constant: 20).isActive = true
        self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        tableHeaderLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        tableHeaderLabel.centerYAnchor.constraint(equalTo: tableHeader.centerYAnchor).isActive = true
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        return cell
    }
    
}

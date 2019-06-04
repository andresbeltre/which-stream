//
//  SearchViewController.swift
//  Which Stream
//
//  Created by Leo Oliveira on 5/8/19.
//  Copyright © 2019 Whcih. All rights reserved.
//

import UIKit

extension SearchViewController: UISearchResultsUpdating {
    /// UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate {
    
    var APP_DEFAULTS: AppDefaults!
    /// Container to hold view and allow for synchronized movement with menu
    var viewContainer: UIView!
    /// Button to trigger/untrigger side menu
    var sideMenuButton: UIButton!
    /// Side menu to display extra information
    var sideMenu: UIView!
    /// Table to display tv show history
    var tableView: UITableView!
    /// Search Controller
    let searchController = UISearchController(searchResultsController: nil)
    /// Array to hold content filtered from search
    var filteredContent = [Content]()
    
    var content = [Content]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        content = [
            Content(genre: "Action", title: "Title 1", rating: 5),
            Content(genre: "Action", title: "Title 2", rating: 5),
            Content(genre: "Action", title: "Title 3", rating: 5),
            Content(genre: "Action", title: "Title 4", rating: 5),
            Content(genre: "Action", title: "Eyo 1", rating: 5),
            Content(genre: "Action", title: "Eyo 2", rating: 5),
            Content(genre: "Action", title: "Eyo 3", rating: 5),
            Content(genre: "Action", title: "Eyo 4", rating: 5)
        ]
        
        // ---------- Initialize properties of current view ---------- \\
        APP_DEFAULTS = AppDefaults(viewController: self, currentVC: SEARCH_VC)
        self.setupLayout()
        
        // ---------- Navigation Bar configuration ---------- \\
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: UIApplication.shared.statusBarFrame.height + 45))
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationItem.titleView = self.searchController.searchBar
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: nil)
        self.navigationItem.rightBarButtonItem?.tintColor = .clear
        definesPresentationContext = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @objc func redirectBarButtonTap() {
        self.sideMenuButton.sendActions(for: .touchUpInside)
    }
    
    func setupLayout() {
        // Instantiate view elements
        self.viewContainer = APP_DEFAULTS.setupViewContainerFor(viewController: self)
        self.sideMenu = self.APP_DEFAULTS.setupSideMenuFor(viewController: self)
        self.sideMenuButton = self.APP_DEFAULTS.sideMenuButton
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .clear
        self.tableView.separatorColor = .white
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.searchController.delegate = self
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search Movies, TV Shows and more..."
        UIBarButtonItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        
        let blur = UIBlurEffect(style: .extraLight)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.alpha = 0.4
        blurView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 75)
        
        // Add elements as subview
        self.viewContainer.addSubview(blurView)
        self.viewContainer.addSubview(self.tableView)
        self.view.bringSubview(toFront: self.sideMenuButton)
        
        // Add constraints
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        blurView.translatesAutoresizingMaskIntoConstraints = false
        
        self.tableView.topAnchor.constraint(equalTo: self.viewContainer.topAnchor, constant: UIApplication.shared.statusBarFrame.height + 75).isActive = true
        self.tableView.leftAnchor.constraint(equalTo: self.viewContainer.leftAnchor).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: self.viewContainer.rightAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.viewContainer.bottomAnchor).isActive = true
        
        blurView.leftAnchor.constraint(equalTo: self.viewContainer.leftAnchor).isActive = true
        blurView.rightAnchor.constraint(equalTo: self.viewContainer.rightAnchor).isActive = true
        blurView.topAnchor.constraint(equalTo: self.viewContainer.topAnchor).isActive = true
        blurView.bottomAnchor.constraint(equalTo: self.tableView.topAnchor).isActive = true
    }
    
    
    func isSearchBarEmpty() -> Bool {
        return self.searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredContent = self.content.filter({( c : Content ) -> Bool in
            return c.title.lowercased().contains(searchText.lowercased())
        })
        
        self.tableView.reloadData()
    }
    
    func isFilteringContent() -> Bool {
        return self.searchController.isActive && !isSearchBarEmpty()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (isFilteringContent()) {
            return self.filteredContent.count
        }
        
        return content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.backgroundColor = .clear
        
        let content: Content
        if (isFilteringContent()) {
            content = self.filteredContent[indexPath.row]
        } else {
            content = self.content[indexPath.row]
        }
        cell.textLabel!.text = content.title
        return cell
    }
}

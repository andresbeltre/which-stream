//
//  SearchViewController.swift
//  Which Stream
//
//  Created by Leo Oliveira on 5/8/19.
//  Copyright © 2019 Whcih. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var APP_DEFAULTS: AppDefaults!
    /// Container to hold view and allow for synchronized movement with menu
    var viewContainer: UIView!
    /// Button to trigger/untrigger side menu
    var sideMenuButton: UIButton!
    /// Side menu to display extra information
    var sideMenu: UIView!
    /// Table to display tv show history
    var tableView: UITableView!
    /// Search Bar
    var searchBar: UISearchBar!
    /// Boolean check for searchbar filtering
    var isSearching = false
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
        
        definesPresentationContext = true
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
        
        self.searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.viewContainer.frame.width, height: 20))
        self.searchBar.delegate = self
        self.searchBar.placeholder = "Search Movies, TV Shows and more..."
        self.searchBar.backgroundImage = UIImage()
        self.searchBar.tintColor = .white
        self.searchBar.barStyle = .blackOpaque
        let searchBarTextField = self.searchBar.value(forKey: "searchField") as? UITextField
        searchBarTextField?.textColor = .white
        let searchBarPlaceholder = searchBarTextField!.value(forKey: "placeholderLabel") as? UILabel
        searchBarPlaceholder?.textColor = UIColor(white: 1, alpha: 0.75)
        let searchIcon = searchBarTextField?.leftView as? UIImageView
        searchIcon?.image = searchIcon?.image?.withRenderingMode(.alwaysTemplate)
        searchIcon?.tintColor = UIColor(white: 1, alpha: 0.75)
        let clearIcon = searchBarTextField?.value(forKey: "clearButton") as? UIButton
        clearIcon?.setImage(UIImage(named: "ClearButton"), for: .normal)
        clearIcon?.currentImage?.withRenderingMode(.alwaysTemplate)
        clearIcon?.tintColor = UIColor(white: 1, alpha: 0.75)
        
        let blur = UIBlurEffect(style: .extraLight)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.alpha = 0.4
        blurView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 75)
        
        // Add elements as subview
        self.viewContainer.addSubview(blurView)
        self.view.addSubview(self.searchBar)
        self.viewContainer.addSubview(self.tableView)
        self.view.bringSubview(toFront: self.searchBar)
        self.view.bringSubview(toFront: self.sideMenu)
        self.view.bringSubview(toFront: self.sideMenuButton)
        
        
        // Add constraints
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        blurView.translatesAutoresizingMaskIntoConstraints = false
        self.searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        self.tableView.topAnchor.constraint(equalTo: blurView.bottomAnchor).isActive = true
        self.tableView.leftAnchor.constraint(equalTo: self.viewContainer.leftAnchor).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: self.viewContainer.rightAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.viewContainer.bottomAnchor).isActive = true
        
        blurView.leftAnchor.constraint(equalTo: self.viewContainer.leftAnchor).isActive = true
        blurView.rightAnchor.constraint(equalTo: self.viewContainer.rightAnchor).isActive = true
        blurView.topAnchor.constraint(equalTo: self.viewContainer.topAnchor).isActive = true
        blurView.heightAnchor.constraint(equalToConstant: UIApplication.shared.statusBarFrame.height+120).isActive = true
        
        self.searchBar.leftAnchor.constraint(equalTo: self.viewContainer.leftAnchor).isActive = true
        self.searchBar.rightAnchor.constraint(equalTo: self.viewContainer.rightAnchor).isActive = true
        self.searchBar.bottomAnchor.constraint(equalTo: self.tableView.topAnchor, constant: -30).isActive = true
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.isSearching = false
        self.searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.setShowsCancelButton(false, animated: true)
        self.isSearching = false
        self.searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.setShowsCancelButton(false, animated: true)
        self.searchBar.text = ""
        self.isSearching = false
        self.searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (self.searchBar.text?.count == 0) {
            self.isSearching = false
        } else {
            self.filteredContent = self.content.filter({( c : Content ) -> Bool in
                return c.title.lowercased().contains(searchText.lowercased())
            })
            
            if (self.filteredContent.count == 0) {
                self.isSearching = false
            } else {
                self.isSearching = true
            }
        }
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.isSearching) {
            return self.filteredContent.count
        }
        
        return content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.backgroundColor = .clear
        cell.textLabel!.textColor = .white
        
        
        let content: Content
        if (self.isSearching) {
            content = self.filteredContent[indexPath.row]
        } else {
            content = self.content[indexPath.row]
        }
        cell.textLabel!.text = content.title
        return cell
    }
}

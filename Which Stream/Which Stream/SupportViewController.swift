//
//  SupportViewController.swift
//  
//
//  Created by Leo Oliveira on 6/15/19.
//

import UIKit

class SupportViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var APP_DEFAULTS: AppDefaults!

    /// Container to hold view and allow for synchronized movement with menu
    var viewContainer: UIView!
    /// Table to display tv show history
    var tableView: UITableView!
    /// Button to trigger/untrigger side menu
    var sideMenuButton: UIButton!
    /// Side menu to display extra information
    var sideMenu: UIView!
    /// Boolean indicator of whether faq cell is expanded
    var isFAQsExpanded = false
    /// Boolean indicator of whether contact cell is expanded
    var contactSupport = false
    /// Boolean indicator of whether community cell is expanded
    var community = false
    /// Expand/Collapse arrow
    var expandCollapse: UIImageView!
    /// Tracks expanded/collapsed status of FAQs section
    var isCollapsed = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // ---------- Initialize properties of current view ---------- \\
        APP_DEFAULTS = AppDefaults(viewController: self, currentVC: SUPPORT_VC)
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
        
        self.expandCollapse = UIImageView(image: UIImage(named: "ExpandArrow"))
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .clear
        self.tableView.separatorColor = .white
        self.tableView.separatorStyle = .none
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let blur = UIBlurEffect(style: .extraLight)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.alpha = 0.4
        blurView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 75)
        
        let viewName = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width-30, height: 75))
        viewName.text = "Support"
        viewName.font = UIFont.systemFont(ofSize: 40)
        viewName.textColor = .white
        viewName.textAlignment = .left
        
        // Add elements as subviews
        self.viewContainer.addSubview(viewName)
        self.viewContainer.addSubview(self.tableView)
        self.viewContainer.addSubview(blurView)
        self.view.bringSubview(toFront: self.sideMenuButton)
        self.viewContainer.bringSubview(toFront: viewName)
        
        // Add view constraints
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
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
        
        self.tableView.topAnchor.constraint(equalTo: blurView.bottomAnchor).isActive = true
        self.tableView.leftAnchor.constraint(equalTo: self.viewContainer.leftAnchor).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: self.viewContainer.rightAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.viewContainer.bottomAnchor).isActive = true
    }
    
    /**
     Action method triggered upon tapping FAQs section header.
 
     - Version: 1.0
     - Author: Leo Oliveira
     */
    @objc func didSelectFAQs() {
        self.isCollapsed = !self.isCollapsed
        if (self.isCollapsed == true) {
            self.expandCollapse.image = UIImage(named: "CollapseArrow")
        } else {
            self.expandCollapse.image = UIImage(named: "ExpandArrow")
        }
        self.tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return 6
        } else if (section == 1) {
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        view.setBackgroundGradient()
        
        let separator = UIView()
        separator.backgroundColor = .white
        let title = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 20))
        title.textColor = .white
        title.font = UIFont.systemFont(ofSize: 30)
        
        view.addSubview(title)
        view.addSubview(separator)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        if (section == 0) {
            title.text = "FAQs"
            view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didSelectFAQs)))
            view.addSubview(self.expandCollapse)
            self.expandCollapse.translatesAutoresizingMaskIntoConstraints = false
            
            title.widthAnchor.constraint(equalToConstant: 80).isActive = true

            self.expandCollapse.leftAnchor.constraint(equalTo: title.rightAnchor).isActive = true
            self.expandCollapse.widthAnchor.constraint(equalToConstant: 20).isActive = true
            self.expandCollapse.heightAnchor.constraint(equalToConstant: 20).isActive = true
            self.expandCollapse.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        } else if (section == 1) {
            title.text = "Contact Support"
            title.widthAnchor.constraint(equalToConstant: 250).isActive = true
        } else {
            title.text = "Community"
            title.widthAnchor.constraint(equalToConstant: 150).isActive = true
        }
        
        title.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        title.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        separator.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        separator.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separator.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -1).isActive = true
        
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0) {
            switch indexPath.row {
                case 0, 2, 4:
                    if (self.isCollapsed) {
                        return 0
                    } else {
                        return 40
                    }
                case 1, 3, 5:
                    if (self.isCollapsed) {
                        return 0
                    } else {
                        return 120
                    }
                default:
                    if (self.isCollapsed) {
                        return 0
                    } else {
                        return 40
                    }
            }
        }
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let selectedBackground = UIView()
        selectedBackground.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        cell.selectedBackgroundView = selectedBackground
        cell.backgroundColor = .clear
        
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
        

        let answer = UILabel(frame: CGRect(x: 25, y: 0, width: self.view.frame.width, height: 40))
        answer.textColor = .white
        answer.lineBreakMode = .byWordWrapping
        answer.numberOfLines = 5
        answer.translatesAutoresizingMaskIntoConstraints = false
        
        
        if (indexPath.section == 0 && self.isCollapsed == false) {
            cell.isUserInteractionEnabled = false
            switch indexPath.row {
                case 0:
                    cell.textLabel?.text = "What is WH!CH?"
                case 1:
                    answer.text = "An app that pairs with streaming services to bring you choices when you can't decide what to watch. Open our app and see what your friends are watching and share what you are watching with them too."
                    cell.addSubview(answer)
                    answer.leftAnchor.constraint(equalTo: cell.leftAnchor, constant: 30).isActive = true
                    answer.rightAnchor.constraint(equalTo: cell.rightAnchor, constant: -25).isActive = true
                    answer.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
                    answer.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
                case 2:
                    cell.textLabel?.text = "How does WH!CH work?"
                case 3:
                    answer.text = "Log in to retrieve your preferences and you can choose to roulette through things you have watched or choose to randomize a new movie, tv show, or cartoon/anime to watch."
                    cell.addSubview(answer)
                    answer.leftAnchor.constraint(equalTo: cell.leftAnchor, constant: 30).isActive = true
                    answer.rightAnchor.constraint(equalTo: cell.rightAnchor, constant: -25).isActive = true
                    answer.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
                    answer.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
                case 4:
                    cell.textLabel?.text = "How can I support WH!CH?"
                case 5:
                    answer.text = "We are a small start up that came up with the idea on a Tuesday. Support can come in all kinds of forms, but the main ways to support are to keep using our app, telling your friends about it, and donating to us!"
                    cell.addSubview(answer)
                    answer.leftAnchor.constraint(equalTo: cell.leftAnchor, constant: 30).isActive = true
                    answer.rightAnchor.constraint(equalTo: cell.rightAnchor, constant: -25).isActive = true
                    answer.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
                    answer.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
                default:
                    cell.textLabel?.text = ""
            }
            
        } else if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                cell.textLabel?.text = "Contact Us"
            } else if (indexPath.row == 1) {
                cell.textLabel?.text = "Rate the app"
            }
        } else {
            
        }
        
        return cell
    }
    
}

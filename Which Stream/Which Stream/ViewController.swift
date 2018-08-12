//
//  ViewController.swift
//  Which Stream
//
//  Created by Andrés Beltré on 7/22/18.
//  Copyright © 2018 Whcih. All rights reserved.
//

import UIKit
import WebKit
class ViewController: UIViewController {
    // Simkl client id used for http request
    let CLIENT_ID = "7b70f5162055cef2014f99d2538f3c1113ff484577d99de7508852d97c3dfa16"
    // Redirect URI to return to application after http request
    let REDIRECT_URI = "which-simkl-authentication://"
    // Standard user data stored
    let USER_DEFAULTS = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Retrieve code to make call for Simkl access token if necessary
        if (USER_DEFAULTS.object(forKey: "simkl-token") == nil) {
            generateToken()
        }
    }
    
    // Responsible for making a GET request to retrieve code necessary to retrieve Simkl's access token.
    func generateToken() {
        let url = URL(string: "https://simkl.com/oauth/authorize?response_type=code&client_id=\(self.CLIENT_ID)&redirect_uri=\(self.REDIRECT_URI)")!
        UIApplication.shared.open(url, options: [:])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


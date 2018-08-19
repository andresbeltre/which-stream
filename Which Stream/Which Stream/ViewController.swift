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
    let CLIENT_ID = "7b70f5162055cef2014f99d2538f3c1113ff484577d99de7508852d97c3dfa16"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        test()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func test(type: [String] = [], genre: [String] = [], service: [String] = ["simkl","netflix"]) {
        let url = URL(string: "https://api.simkl.com/search/tv?q=the%20office&client_id=\(CLIENT_ID)")!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response, let data = data {
                print(response)
                print(String(data: data, encoding: .utf8)!)
            } else {
                print(error!)
            }
        }
        
        task.resume()
    }
}


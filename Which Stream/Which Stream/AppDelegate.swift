//
//  AppDelegate.swift
//  Which Stream
//
//  Created by Andrés Beltré on 7/22/18.
//  Copyright © 2018 Whcih. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let CLIENT_ID = "7b70f5162055cef2014f99d2538f3c1113ff484577d99de7508852d97c3dfa16"
    let CLIENT_SECRET = "2f6955804d65303dbad29dc27e960b8979a660525748dd5d3fe699178159d6fc"
    let USER_DEFAULTS = UserDefaults.standard
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        // Retrieve the components attached to the url returned from call
        let components = NSURLComponents(url: url, resolvingAgainstBaseURL: false)
        // Convert names and values in query to a list of type NSURLQueryItem
        let redirectData = (components?.queryItems)! as [NSURLQueryItem]
        // Check which redirect URI is responsible for bringing the data back to the app
        if (url.scheme == "which-simkl-authentication") {
            if let key = redirectData.first?.name, let code = redirectData.first?.value {
                if (key == "code") {
                    let token_url = URL(string: "https://api.simkl.com/oauth/token")
                    var req = URLRequest(url: token_url!)
                    req.httpMethod = "POST"
                    req.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    req.httpBody = "{\n \"code\": \"\(code)\",\n \"client_id\": \"\(CLIENT_ID)\",\n \"client_secret\": \"\(CLIENT_SECRET)\",\n \"redirect_uri\": \"which-simkl-authentication://\",\n \"grant_type\": \"authorization_code\"\n}".data(using: .utf8)
                    
                    let task = URLSession.shared.dataTask(with: req) { data, response, error in
                        do {
                            if let data = data {
                                let json = try JSONSerialization.jsonObject(with: data) as! [String: Any]
                                let access_token = json["access_token"] as! String
                                self.USER_DEFAULTS.set(access_token, forKey: "simkl-token")
                            } else {
                                debugPrint(error!)
                            }
                        } catch {
                            debugPrint("Error deserializing JSON: \(error)")
                        }
                    }
                    task.resume()
                }
            }
        }
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


//
//  ViewController.swift
//  Steam
//
//  Created by apple on 02/07/18.
//  Copyright © 2018 shiv. All rights reserved.
//

import UIKit
import FacebookLogin
import GoogleSignIn

import ProgressHUD

class ViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
        let signInButton = GIDSignInButton(frame: CGRect(x: 145, y: 600, width: 100, height: 50))
        view.addSubview(signInButton)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil {
            print(error)
            return
        }
        
        // if no error then go to gameViewController
        ProgressHUD.showSuccess("Successfully signed in with \(user.profile.email as! String)", interaction: false)
        print("user sign in with: \(user.profile.email)")
        performSegue(withIdentifier: "gameViewController", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "gameViewController" {
            if segue.destination is GameViewController {
                // do nothing go to gameViewController
            }
        }
    }
    
}


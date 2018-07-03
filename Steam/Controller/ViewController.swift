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

class ViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
        let signInButton = GIDSignInButton(frame: CGRect(x: 80, y: 600, width: 100, height: 50))
        view.addSubview(signInButton)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil {
            print(error)
            return
        }
        print(user.profile.email)
    }

}


//
//  LoginViewController.swift
//  SALScheduler
//
//  Created by Denim Mazuki on 3/25/17.
//  Copyright © 2017 Denim Mazuki. All rights reserved.
//

import UIKit
import Firebase
import FirebaseGoogleAuthUI
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInUIDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
        
        // TO-DO: Configure the sign-in button look/feel
    }

    

}

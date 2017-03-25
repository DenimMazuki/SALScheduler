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
import FirebaseAuth

class LoginViewController: UIViewController, GIDSignInUIDelegate {
    
    // Sign-in handler
    var handle: FIRAuthStateDidChangeListenerHandle?

    override func viewDidLoad() {
        super.viewDidLoad()

        GIDSignIn.sharedInstance().uiDelegate = self
        
        // If successful sign-in, let user into the app
        GIDSignIn.sharedInstance().signInSilently()
        handle = FIRAuth.auth()?.addStateDidChangeListener() {
            (auth, user) in
            
            if (user != nil) {
                // Send log-in event
                
                // Perform segue to HomeVC
                let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "TestViewController") as! TestViewController
                
                self.present(homeViewController, animated: true, completion: nil)
            }
            
        }
        
        
        // TO-DO: Configure the sign-in button look/feel
    }
    
    // Remove listener in deinit
    deinit {
        if let handle = handle {
            FIRAuth.auth()?.removeStateDidChangeListener(handle)
        }
    }

    

}

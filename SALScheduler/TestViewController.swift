//
//  TestViewController.swift
//  SALScheduler
//
//  Created by Denim Mazuki on 3/25/17.
//  Copyright © 2017 Denim Mazuki. All rights reserved.
//

import UIKit
import FirebaseAuth

class TestViewController: UIViewController {

    var user: FIRUser?
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        user = FIRAuth.auth()?.currentUser
        
        usernameLabel.text = user?.displayName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}

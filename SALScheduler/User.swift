//
//  User.swift
//  SALScheduler
//
//  Created by Ian Loftis on 3/25/17.
//  Copyright © 2017 Denim Mazuki. All rights reserved.
//

import Foundation
class User: NSObject {
    var requests: [Request]
    var classes: [Class]
    var username: String
    var displayName: String
    
    init(username:String, displayName: String, classes: Array<String>, requests:Array<Request>){
        self.username = username
        self.displayName = displayName
        self.classes = classes
        self.requests = requests
    }
    
    
}

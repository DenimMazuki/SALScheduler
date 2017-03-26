//
//  Class.swift
//  SALScheduler
//
//  Created by Ian Loftis on 3/25/17.
//  Copyright © 2017 Denim Mazuki. All rights reserved.
//

import Foundation

class Class: NSObject {
    var id: String;
    var cpids: Array<String>;
    var studentids: Array<String>;
    init(id:String, cpids:Array<String>, studentids:Array<String>)
    {
        self.id = id;
        self.cpids = cpids;
        self.studentids = studentids;
    }
}

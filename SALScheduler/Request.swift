//
//  Request.swift
//  SALScheduler
//
//  Created by Ian Loftis on 3/25/17.
//  Copyright © 2017 Denim Mazuki. All rights reserved.
//
import Foundation

class Request: NSObject {
    var reqID = String;
    var category = String;
    var classID = String;
    var studentID = String;
    var timestamp = Int;
    var reqDesc = String;
    
    init(reqID: String, category:String, classID:String, studentID: String, timestamp:Int, reqDesc:String)
    {
        self.reqID = reqID;
        self.category = category;
        self.classID = classID;
        self.studentID = studentID;
        self.timestamp = timestamp;
        self.reqDesc = reqDesc;
    }
}

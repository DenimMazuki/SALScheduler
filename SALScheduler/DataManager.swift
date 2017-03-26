//
//  DataManager.swift
//  SALScheduler
//
//  Created by Ian Loftis on 3/25/17.
//  Copyright © 2017 Denim Mazuki. All rights reserved.
//

import Firebase


/*
TODO:
change the way this functions so that instead of listening for requests
added or deleted, it does a one time load of the requests for the class when
the class is set. And then returns the
*/

class DataManager: User {
    lazy var ref:FIRDatabaseReference = FIRDatabase.database().reference()
    var classRef:FIRDatabaseReference!
    var cpRef:FIRDatabaseReference!
    var userRef: FIRDatabaseReference!
    var reqRef: FIRDatabaseReference!
    var cpids:Array<String>;
    var users:Array<User>;
    var user: User
    var username: String
//    var reqs:Array<Request>;
    var reqs:Dictionary<String,Request>;
    var classes:Array<Class>;
    var userClasses: Array<String>;
    var userReqs:Array<Request>;
//    var classToStudents:Dictionary<String,Array<String>>
    var currClass:String;
    
    
    init(username: String){
        self.username = username
        self.userRef = ref.child("users")
        self.reqRef = ref.child("requests")
        self.classRef = ref.child("classes")
        self.cpRef = ref.child("cps")
        
        classRef.observeSingleEvent(of:.value, with{ (snapshot) in
            let value = snapshot.value as? NSDictionary
            
            for (id,classval) in value{
                var cpArray: [String] = []
                for cpID in value?["CPids"]{
                    cpArray.append(cpID)
                }
                
                var studentsArray: [String] = []
                for studentID in value?["students"]
                {
                    studentsArray.append(studentID);
                }
                
                var c = Class(id: id, cpids: cpArray, studentids: studentsArray)
            }
            
            }) { (error) in
                print(error.localizedDescription)
        }
        
        userRef.child(username).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            
            if(snapshot.hasChild("classes")){
                for classval in value?["classes"]{
                    self.userClasses.append(classval);
                }
            }
            
            //change the below code from userClasses to "classes"
            //if we want to make it so that every user is on every class
            self.user = User(username: username,
                displayName: value?["display-name"],
                classes: userClasses,
                requests: userReqs)
            
            }) { (error) in
                print(error.localizedDescription)
        }
        
        loadRequests()
    }
    
    func loadRequests(){
        reqRef.child(currClass).observeSingleEvent(of: .value, with: { (snapshot) in
            let reqDict = snapshot.value as? [String : AnyObject] ?? [:]
            var req = Request(reqID: snapshot.key as String,
                category: reqDict["category"],
                classID: reqDict["class"],
                studentID: reqDict["student-id"],
                timestamp: reqDict["timestamp"],
                reqDesc: reqDict["description"])
            self.reqs.append(req)
            
            }) { (error) in
                print(error.localizedDescription)
        }
    }
    
    
    func setClass(currClass: String){
        self.currClass = currClass;
        loadRequests();
    }
    
    func detatchListeners(){
        reqRef.removeAllObservers();
        classRef.removeAllObservers();
        cpRef.removeAllObservers();
        userRef.removeAllObservers();
    }
    
    func addRequest(req: Request){
        self.reqs.append(req)
        let key = req.reqID;
        reqdata = ["\(key)/student-id":req.studentID,
            "\(key)/category":req.category,
            "\(key)/description":req.reqDesc,
            "\(key)/class":req.classID,
            "\(key)/timestamp":req.timestamp]
        self.reqRef.child(self.currClass).updateChildValues(reqdata)
        //probably want to update the view controller here in some way
    }
    
    //give the method the index of the currently selected request to remove
    func removeRequestAtIndex(reqIndex:Int){
        //this may need to be removed to prevent double removals (depends on whether or not the listener is called after removing it from the db
        self.reqs.remove(at:reqIndex)
        
        FIRDatabase.remove(FIRDatabase.database().reference().child("requests").child(self.currClass).child(reqs[reqIndex].reqID))
    }
    
    
    func indexOfRequest(reqID: Int) -> Int
    {
        var index = 0
        for  req in self.reqs {
            if req.reqID == req.key {
                return index
            }
            index += 1
        }
        return -1
    }
    
}
































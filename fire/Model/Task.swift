//
//  Task.swift
//  fire
//
//  Created by Артём Коротков on 06.09.2022.
//

import Foundation
import Firebase

struct Task {
    let title: String
    let userID: String
    let ref: Firebase.DatabaseReference?
    var completed: Bool = false
    
    init(title: String, userID: String) {
        self.title = title
        self.userID = userID
        self.ref = nil
    }
    
    init(snapshot: Firebase.DataSnapshot) {
        let snapshotValue = snapshot.value as! [String:AnyObject]
        title = snapshotValue["title"] as! String
        userID = snapshotValue["userID"] as! String
        completed = snapshotValue["completed"] as! Bool
        ref = snapshot.ref
    }
    
    func converToDic() -> Any {
      return  ["title": title, "userID": userID, "completed": completed]
    }
    
}

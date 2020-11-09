//
//  User.swift
//  YYCFoodTrucks-Operator
//
//  Created by apple on 2020-11-08.
//

import Foundation

class User {
    var uid: String
    var email: String?
    var displayName: String?

    init(uid: String, displayName: String?, email: String?) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
    }

}

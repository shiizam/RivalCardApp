//
//  User.swift
//  Rivals
//
//  Created by Cody hancock on 2/24/24.
//

import Foundation


struct User: Codable {
    var email       = ""
    var firstName   = ""
    var lastName    = ""
}


struct NewUser: Codable {
    var email           = ""
    var username        = ""
    var password        = ""
}

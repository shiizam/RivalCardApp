//
//  User.swift
//  Rivals
//
//  Created by Cody hancock on 2/24/24.
//

import Foundation


struct User: Codable, Hashable {
    let id          : Int
    let email       : String
    let username    : String
}


struct NewUser: Codable {
    let email               : String
    let username            : String
    let password            : String
    let confirm_password    : String
}

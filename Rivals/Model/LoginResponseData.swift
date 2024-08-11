//
//  ResponseData.swift
//  Rivals
//
//  Created by Cody hancock on 8/5/24.
//

import Foundation

struct LoginResponseData: Codable {
    let expiry  : String?
    let token   : String
    let user    : User
}

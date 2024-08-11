//
//  DecksResponseData.swift
//  Rivals
//
//  Created by Cody hancock on 8/8/24.
//

import Foundation

struct DecksResponseData: Codable, Identifiable, Hashable {
    let id: Int?
    let deck_name: String
    let card_list: [String: Int]?
    let deck_leader: String?
    let user: Int?
    let hunter_deck: Bool
}

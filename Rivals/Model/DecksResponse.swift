//
//  DecksResponseData.swift
//  Rivals
//
//  Created by Cody hancock on 8/8/24.
//

import Foundation

struct DecksResponseDta: Codable, Identifiable, Hashable {
    let id: Int
    let deck_name: String
    var card_list: [String: Int]?
    let deck_leader: String?
    let deck_agenda: String?
    let deck_haven: String?
    let user: Int?
    let hunter_deck: Bool
    let faction_total: Int
    let library_total: Int
    let deck_faction: String
    let deck_clan: String
}

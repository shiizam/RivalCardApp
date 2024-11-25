//
//  DeckRD.swift
//  Rivals
//
//  Created by Cody hancock on 10/11/24.
//

import SwiftUI
import SwiftData


@Model
class DecksResponseData: Codable, Identifiable, ObservableObject {
    
    @Attribute(.unique)
    var id: Int
    var deck_name: String
    var card_list: [String: Int]?
    var deck_leader: String?
    var deck_agenda: String?
    var deck_haven: String?
    var user: Int?
    var hunter_deck: Bool
    var faction_total: Int
    var library_total: Int
    var deck_faction: String
    var deck_clan: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case deck_name
        case card_list
        case deck_leader
        case deck_agenda
        case deck_haven
        case user
        case hunter_deck
        case faction_total
        case library_total
        case deck_faction
        case deck_clan
    }
    
    init(id: Int, deck_name: String, card_list: [String: Int]? = nil, deck_leader: String? = nil,
         deck_agenda: String? = nil, deck_haven: String? = nil, user: Int? = nil,
         hunter_deck: Bool, faction_total: Int, library_total: Int,
         deck_faction: String, deck_clan: String) {
        
        self.id = id
        self.deck_name = deck_name
        self.card_list = card_list
        self.deck_leader = deck_leader
        self.deck_agenda = deck_agenda
        self.deck_haven = deck_haven
        self.user = user
        self.hunter_deck = hunter_deck
        self.faction_total = faction_total
        self.library_total = library_total
        self.deck_faction = deck_faction
        self.deck_clan = deck_clan
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.deck_name = try container.decode(String.self, forKey: .deck_name)
        self.card_list = try container.decode([String: Int].self, forKey: .card_list)
        self.deck_leader = try container.decode(String?.self, forKey: .deck_leader)
        self.deck_agenda = try container.decode(String?.self, forKey: .deck_agenda)
        self.deck_haven = try container.decode(String?.self, forKey: .deck_haven)
        self.user = try container.decode(Int?.self, forKey: .user)
        self.hunter_deck = try container.decode(Bool.self, forKey: .hunter_deck)
        self.faction_total = try container.decode(Int.self, forKey: .faction_total)
        self.library_total = try container.decode(Int.self, forKey: .library_total)
        self.deck_faction = try container.decode(String.self, forKey: .deck_faction)
        self.deck_clan = try container.decode(String.self, forKey: .deck_clan)
    }
    
    func encode(to encoder: Encoder) throws {
        // TODO: Handle encoding if needed
    }
}

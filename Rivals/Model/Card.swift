//
//  Card.swift
//  Rivals
//
//  Created by Cody hancock on 3/14/24.
//

import SwiftUI
import SwiftData



// Struct for Coding & Decoding JSON data from API call
@Model
class Card: Codable, Identifiable, ObservableObject {
   
      
    
    @Attribute(.unique)
    var id: String
    var name: String
    var imageURL: String
    var illustrator: String
    var cardpool: String
    var card_set: String
    var card_stack: String
    var card_text: String
    var agenda: Int?
    var attack: [String?]
    var blood: Int?
    var blood_potency: Int?
    var blood_potency_requirement: Int?
    var clan: String?
    var card_type: [String?]
    var copies: Int?
    var damage: Int?
    var disciplines: [String?]
    var flavor: String?
    var physical: Int?
    var social: Int?
    var mental: Int?
    var reaction: [String?]
    var shield: Int?
    

    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageURL
        case illustrator
        case cardpool
        case card_set
        case card_stack
        case card_text
        case agenda
        case attack
        case blood
        case blood_potency
        case blood_potency_requirement
        case clan
        case card_type
        case copies
        case damage
        case disciplines
        case flavor
        case physical
        case social
        case mental
        case reaction
        case shield
    }
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.imageURL = try container.decode(String.self, forKey: .imageURL)
        self.illustrator = try container.decode(String.self, forKey: .illustrator)
        self.cardpool = try container.decode(String.self, forKey: .cardpool)
        self.card_set = try container.decode(String.self, forKey: .card_set)
        self.card_stack = try container.decode(String.self, forKey: .card_stack)
        self.card_text = try container.decode(String.self, forKey: .card_text)
        self.agenda = try container.decode(Int?.self, forKey: .agenda)
        self.attack = try container.decode([String?].self, forKey: .attack)
        self.blood = try container.decode(Int?.self, forKey: .blood)
        self.blood_potency = try container.decode(Int?.self, forKey: .blood_potency)        
        self.blood_potency_requirement = try container.decode(Int?.self, forKey: .blood_potency_requirement)
        self.clan = try container.decode(String?.self, forKey: .clan)
        self.card_type = try container.decode([String?].self, forKey: .card_type)
        self.copies = try container.decode(Int?.self, forKey: .copies)
        self.damage = try container.decode(Int?.self, forKey: .damage)
        self.disciplines = try container.decode([String?].self, forKey: .disciplines)
        self.flavor = try container.decode(String?.self, forKey: .flavor)
        self.physical = try container.decode(Int?.self, forKey: .physical)
        self.social = try container.decode(Int?.self, forKey: .social)
        self.mental = try container.decode(Int?.self, forKey: .mental)
        self.reaction = try container.decode([String?].self, forKey: .reaction)
        self.shield = try container.decode(Int?.self, forKey: .shield)
    }
    
    func encode(to encoder: Encoder) throws {
        // TODO: Handle encoding if needed to here
    }
}



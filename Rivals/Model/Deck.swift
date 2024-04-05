//
//  Deck.swift
//  Rivals
//
//  Created by Cody hancock on 3/28/24.
//

import Foundation
import SwiftData

@Model
class Deck {
    
    @Attribute(.unique)
    var name: String
    var deckType: String
    var cardSelection: [Int]
    
    init(name: String, deckType: String, cardSelection: [Int]) {
        self.name = name
        self.deckType = deckType
        self.cardSelection = cardSelection
    }
}

//
//  CardHelpers.swift
//  Rivals
//
//  Created by Cody hancock on 2/10/25.
//

import Foundation

func maxCopiesAllowed(for cardName: String, in cards: [Card]) -> Int {
    if let card = cards.first(where: {$0.name == cardName }) {
        if card.card_stack == "faction" || card.card_stack == "agenda" || card.card_stack == "haven" {
            return 1
        } else {
            return 3
        }
    }
    return 3
}

func rangeForCard(_ card: String, cardType: String) -> ClosedRange<Int> {
    
    if cardType == "faction" {
        return 0...1
    } else {
        return 0...3
    }
}

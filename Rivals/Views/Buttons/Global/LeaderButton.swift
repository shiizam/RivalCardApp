//
//  LeaderButton.swift
//  Rivals
//
//  Created by Cody hancock on 2/5/25.
//

import SwiftUI

struct LeaderButton: View {
    @Binding var hasLeader: Bool
    @Binding var leaderCard: String
    
    var card: Card
    
    var body: some View {
        if card.card_stack == "faction" {
            if hasLeader != true && leaderCard.isEmpty {
                EmptyLeaderButton()
                    .onTapGesture {
                        hasLeader = true
                        leaderCard = card.name
                    }
            } else if hasLeader && card.name == leaderCard {
                FilledLeaderButton()
                    .onTapGesture {
                        hasLeader = false
                        leaderCard = ""
                    }
            }
        }
    }
}


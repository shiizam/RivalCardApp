//
//  EditCellView.swift
//  Rivals
//
//  Created by Cody hancock on 10/8/24.
//

import SwiftUI

struct EditCellView: View {
    
    let card: Card
    @Binding var qty: Int
    @Binding var factionTotal: Int
    @Binding var libraryTotal: Int
    @Binding var leaderCard: String
    @Binding var hasLeader: Bool
    var factionMax = 7
    var libraryMax = 40
    var maxQty: Int
    
    
    var body: some View {
        
        HStack {
            
            Text(card.name)
                .font(.headline).bold()
                .foregroundStyle(.primary)
            
            Text("x: \(qty)")
                .font(.headline)
                .foregroundStyle(.primary)
            
            Spacer()
            
            
            
            HStack {
                
                LeaderButton(hasLeader: $hasLeader, leaderCard: $leaderCard, card: card)

                
                RemoveCardButton()
                    .opacity(qty > 0 ? 1.0 : 0.5)
                    .disabled(qty == 0)
                    .onTapGesture {
                        if qty > 0 {
                            qty -= 1
                            decreaseTotals(cardType: card.card_stack)
                        }
                    }
                

                
              
                AddCardButton()
                    .opacity(qty < maxQty ? 1.0 : 0.5)
                    .disabled(qty >= maxQty)
                    .onTapGesture {
                        if qty < maxQty {
                            qty += 1
                            increaseTotals(cardType: card.card_stack)
                        }
                    }
            }
        }
    }
}

extension EditCellView {
    private func increaseTotals(cardType: String) {
        if cardType == "faction" && factionTotal < factionMax {
            factionTotal += 1
        } else if cardType == "library" && libraryTotal < libraryMax {
            libraryTotal += 1
        }
    }
    
    private func decreaseTotals(cardType: String) {
        if cardType == "faction" && factionTotal > 0 {
            factionTotal -= 1
        } else if cardType == "library" && libraryTotal > 0 {
            libraryTotal -= 1
        }
    }
}

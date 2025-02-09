//
//  AllCardsListCell.swift
//  Rivals
//
//  Created by Cody hancock on 2/9/25.
//

import SwiftUI

struct AllCardsListCell: View {
    
    let card: Card
    
    
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: card.imageURL)) { image in
                image
                    .resizable()
            } placeholder: {
                Text("Loading...")
                    .foregroundStyle(.white)
            }
            .frame(width: 100, height: 150)
            
            VStack(alignment: .leading) {
                
                Text(card.name)
                    .font(.title3)
                    .fontWeight(.bold)
                
                if card.clan == nil {
                    Text("Faction: None")
                        .font(.caption)
                        .fontWeight(.medium)
                } else {
                    Text("Faction: \(card.clan!)")
                        .font(.caption)
                        .fontWeight(.medium)
                }
                Text("Max Copies: \(card.copies ?? 1) ")
                    .font(.caption)
                    .fontWeight(.medium)
                
                Text("Card Set: \(card.card_set)")
                    .font(.caption)
                    .fontWeight(.medium)
                
                Text("Card Stack: \(card.card_stack.capitalized)")
                    .font(.caption)
                    .fontWeight(.medium)
                                   
                if card.card_type == ["attack"] || card.card_type == ["reaction"] {
                    ForEach(card.card_type, id: \.self) { type in
                        Text("Type: \(type!.capitalized)")
                            .font(.caption)
                            .fontWeight(.medium)
                    }
                }
            }
            
        }
    }
}

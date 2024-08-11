//
//  DeckView.swift
//  Rivals
//
//  Created by Cody hancock on 8/9/24.
//

import SwiftUI
import SwiftData


struct DeckView: View {
    
    @Query(sort: \Card.id) private var cards: [Card]
    let deck: DecksResponseData
    
    var body: some View {
        
        ZStack {
            
            BackgroundView()
            
            VStack(alignment: .leading) {
                Text(deck.deck_name)
                    .font(.title)
                    .padding()
                
               
                    
                    
                
                if let cardList = deck.card_list {
                    // sort dictionary by key and have var for key, val pairs (cardName = key, quantity = value)
                    List(cardList.sorted(by: { $0.key < $1.key }), id: \.key) { cardName, quantity in
                        
                        if let card = cards.first(where: { $0.name == cardName }) {
                            
                            HStack {
                                AsyncImage(url: URL(string: card.imageURL)) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 70)
                                } placeholder: {
                                    Rectangle()
                                        .foregroundColor(.gray)
                                        .frame(width: 50, height: 70)
                                }
                                
                                VStack(alignment: .leading) {
                                    Text(card.name)
                                    Spacer()
                                    Text("Qty: \(quantity)")
                                }
                            }
                            .padding(.vertical, 5)
                        }
                    }
                } else {
                    Text("No cards available")
                        .font(.headline)
                        .padding()
                }
            }
            .navigationTitle(deck.deck_name)
        }
    }
}

#Preview {
    DeckView(deck: FakeDeck.fakeData)
}

struct FakeDeck {
    static let fakeData = DecksResponseData(id: 2, deck_name: "TestingData", card_list: ["Crossbow": 3, "Calcinatio": 3, "Blood Makes Noise": 3, "Claudia Sterling": 1, "Back to Formula": 3, "April Smith": 1, "Backup": 3, "Candi Liu": 1, "Alejandro Lopez": 1, "Absolution": 3, "Break Down": 3, "Darius Wolfe": 1, "All the Angles": 3, "Blood of Potency": 3, "Caleb Walker": 1, "Aurora Nix": 1], deck_leader: "Aurora Nix", user: 1, hunter_deck: false)
}

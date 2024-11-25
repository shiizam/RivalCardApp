//
//  DeckView.swift
//  Rivals
//
//  Created by Cody hancock on 8/9/24.
//

import SwiftUI
import SwiftData


struct DeckView: View {
    
    @EnvironmentObject var newDeckVM: NewDeckViewModel
    @Query(sort: \Card.id) private var cards: [Card]
    
    let deck: DecksResponseData
    
    @State private var showEditDeckView = false
    
    
    
    var body: some View {
        
        ZStack {
            
            BackgroundView()
            
            VStack(alignment: .leading) {
                
                if let cardList = deck.card_list {

                    List(cardList.sorted(by: { $0.key < $1.key }), id: \.key) { cardName, quantity in
                        
                        if let card = cards.first(where: { $0.name == cardName }) {
                            DeckCellView(imgUrl: card.imageURL, cardName: cardName, qty: quantity)
                                .listRowBackground(Color.gray)
                        }
                    }
                    .scrollContentBackground(.hidden)
                    
                } else {
                    Text("No cards available")
                        .font(.headline)
                        .padding()
                }
            }
            .navigationTitle(deck.deck_name)
            .toolbar {
                ToolbarItem {
                    Button("Edit") {
                        print("Edit deck button tapped!")
                        showEditDeckView.toggle()
                    }
                    .foregroundStyle(.blue)
                    .sheet(isPresented: $showEditDeckView) {
                        NewDeckView(initialDeck: deck)
                            .environmentObject(newDeckVM)
                    }
                }
                
            }
        }
    }
}

//#Preview {
//    DeckView(deck: FakeDeck.fakeData)
//}
//
//struct FakeDeck {
//    static let fakeData = DecksResponseData(id: 2, deck_name: "TestingData", card_list: ["Crossbow": 3, "Calcinatio": 3, "Blood Makes Noise": 3, "Claudia Sterling": 1, "Back to Formula": 3, "April Smith": 1, "Backup": 3, "Candi Liu": 1, "Alejandro Lopez": 1, "Absolution": 3, "Break Down": 3, "Darius Wolfe": 1, "All the Angles": 3, "Blood of Potency": 3, "Caleb Walker": 1, "Aurora Nix": 1], deck_leader: "Aurora Nix", user: 1, hunter_deck: false)
//}

//
//  AllCardsSheetView.swift
//  Rivals
//
//  Created by Cody hancock on 10/12/24.
//

import SwiftUI
import SwiftData

struct AllCardsSheetView: View {
    
    @Binding var cardList: [String: Int]
    @ObservedObject var deck: DecksResponseData
    
    @Query(sort: \Card.id) private var cards: [Card]
    
    // Temp Variables to hold changes before saving
    @State private var currLeader: String
    @State private var currAgenda: String
    @State private var currHaven: String
    
    
    
    // Search bar functionallity
    @State private var searchText: String = ""
    @State private var deckCardIDs: Set<String> = []
    
    var filteredCards: [Card] {
        guard !searchText.isEmpty else { return cards }
        return cards.filter {
            $0.id.localizedCaseInsensitiveContains(searchText) || // search by id
            $0.clan?.localizedCaseInsensitiveContains(searchText) ?? false || // search by clan
            $0.card_type.compactMap { $0?.lowercased() }.contains { $0.contains(searchText.lowercased())} || // search by cardType
            $0.attack.compactMap {$0?.lowercased() }.contains { $0.contains(searchText.lowercased())} // search by attack
        }
    }
    
    
    init(deck: DecksResponseData, cardList: Binding<[String: Int]>) {
        self.deck = deck
        self._cardList = cardList
        _currAgenda = State(initialValue: deck.deck_agenda ?? "")
        _currHaven = State(initialValue: deck.deck_haven ?? "")
        _currLeader = State(initialValue: deck.deck_leader ?? "")
//        _cardList = State(initialValue: deck.card_list ?? [:])
    }
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                
                List(filteredCards, id: \.id) { card in
                    HStack(alignment: .center) {
                        
                        
                        VStack(alignment: .leading) {
                            
                            Text(card.name)
                                .font(.title3)
                                .fontWeight(.medium)
                                .foregroundStyle(.white)
                            
                            AsyncImage(url: URL(string: card.imageURL)) { image in
                                image
                                    .resizable()
                                    .cornerRadius(10)
                            } placeholder: {
                                
                                Rectangle()
                                    .foregroundStyle(.secondary)
                            }
                            .frame(width: 60, height: 100)
                            

                            
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .center) {
                            
                            Text("Qty: \(cardList[card.name, default: 0])")
                                .font(.headline)
                                .frame(alignment: .topLeading)
                                .multilineTextAlignment(.leading)
                            
                            // Stepper Counter for cards
                            Stepper(value: Binding(get: {
                                cardList[card.name, default: 0]
                            }, set: { newValue in
                                cardList[card.name] = newValue
                            }), in: rangeForCard(card.name, cardType: card.card_stack)) {
                                EmptyView()
                            }
                            .frame(width: 100, height: 30)
                        }
                    }
                }
            }
            .navigationTitle("Add Cards")
            .searchable(text: $searchText, prompt: "Search Cards")
            .frame(maxWidth: .infinity)
        }
    }
        
}


extension AllCardsSheetView {
    private func rangeForCard(_ card: String, cardType: String) -> ClosedRange<Int> {
        
        if cardType == "faction" {
            return 0...1
        } else {
            return 0...3
        }
    }
}

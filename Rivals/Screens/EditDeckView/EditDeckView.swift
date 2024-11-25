//
//  EditDeckView.swift
//  Rivals
//
//  Created by Cody hancock on 8/14/24.
//

import SwiftUI
import SwiftData

struct EditDeckView: View {
    
    @EnvironmentObject var viewModel: NewDeckViewModel
    @Query(sort: \Card.id) private var cards: [Card]
    
    @State private var showAllCards = false
    @State private var cardList: [String: Int]
    
    
    let deck: DecksResponseData
    
    init(deck:DecksResponseData) {
        self.deck = deck
        _cardList = State(initialValue: deck.card_list ?? [:])
    }
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                BackgroundView()
                
                VStack {
                    
//                    if let cardList = deck.card_list {
                        
                        List(cardList.sorted(by: {$0.key < $1.key }), id: \.key) { cardName, quantity in
                            
                            let maxCopies = maxCopiesAllowed(for: cardName)
                            
                            EditCellView(cardName: cardName, qty: Binding(
                                get: { cardList[cardName, default: 0] },
                                set: { newValue in 
                                    // Update the cardList when quantity changes
                                    cardList[cardName] = newValue
                                    
                                    // If the new value is 0, remove the card from the card list
                                    if newValue == 0 {
                                        cardList.removeValue(forKey: cardName)
                                    }
                                }
                            ),
                            maxQty: maxCopies
                                         
                            )
                            .alignmentGuide(.listRowSeparatorLeading) { ViewDimensions in
                                return ViewDimensions[.listRowSeparatorLeading] - 35
                            }
                            
                            .listRowBackground(Color.gray)
                            
                        }
                        .scrollContentBackground(.hidden)
                        
                        Button {
                            showAllCards.toggle()
                        } label: {
                            Text("All Cards")
                                .frame(width: 140, height: 35)
                                .foregroundStyle(.white)
                                .padding(.vertical)
                        }
                        .sheet(isPresented: $showAllCards) {
                            
                            AllCardsSheetView(deck: deck, cardList: $cardList)
                                .alignmentGuide(.listRowSeparatorLeading) { ViewDimensions in
                                    return ViewDimensions[.listRowSeparatorLeading] - 35
                                }
                        }
                        .presentationDetents([.fraction(0.75)])
                        .presentationDragIndicator(.visible)
                        .presentationBackground(.ultraThinMaterial)
//                    }
                }
                
            }
        }
        .navigationTitle("Edit \(deck.deck_name)")
        .onChange(of: cardList) {
            deck.card_list = cardList
        }
        
    }
}


extension EditDeckView {
    private func maxCopiesAllowed(for cardName: String) -> Int {
        if let card = cards.first(where: {$0.name == cardName }) {
            if card.card_stack == "faction" {
                return 1
            } else {
                return 3
            }
        }
        return 3
    }
}

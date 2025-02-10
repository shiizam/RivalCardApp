//
//  AllCardsSheetView.swift
//  Rivals
//
//  Created by Cody hancock on 10/12/24.
//

import SwiftUI
import SwiftData

struct AllCardsSheetView: View {
    @ObservedObject var viewModel: NewDeckViewModel
//    @Query(sort: \Card.id) private var cards: [Card]
    var cards: [Card]
    
    
    // Search bar functionallity
    @State private var searchText: String = ""
//    @State private var deckCardIDs: Set<String> = []
    
    var filteredCards: [Card] {
        guard !searchText.isEmpty else { return cards }
        return cards.filter {
            $0.id.localizedCaseInsensitiveContains(searchText) || // search by id
            $0.clan?.localizedCaseInsensitiveContains(searchText) ?? false || // search by clan
            $0.card_type.compactMap { $0?.lowercased() }.contains { $0.contains(searchText.lowercased())} || // search by cardType
            $0.attack.compactMap {$0?.lowercased() }.contains { $0.contains(searchText.lowercased())} // search by attack
        }
    }
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                
                VStack(spacing: 0) {
                    
                    Spacer()
                    
                    List(filteredCards, id: \.self) { card in
                        AllCardsListCell(card: card)
                       
                        Spacer()
                        
                        if (viewModel.newDeckDict[card.name] ?? 0) < 1 {
                            Button("Add") {
                                viewModel.newDeckDict[card.name] = 1
                                if (card.card_stack == "faction") {
                                    viewModel.factionTotal += 1
                                } else {
                                    viewModel.libraryTotal += 1
                                }
                            }
                            .buttonStyle(.bordered)
                            
                        }
                    }
                    .scrollContentBackground(.hidden)
                    
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

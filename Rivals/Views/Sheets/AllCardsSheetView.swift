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
                
                // Searchable Card List (to add new cards)
                    TextField("Search Cards", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                
                    Spacer()
                
                    List(filteredCards, id: \.self) { card in
                        AllCardsListCell(card: card)
//                        HStack {
//                            AsyncImage(url: URL(string: card.imageURL)) { image in
//                                image
//                                    .resizable()
//                            } placeholder: {
//                                Text("Loading...")
//                                    .foregroundStyle(.white)
//                            }
//                            .frame(width: 100, height: 150)
//                            
//                            VStack(alignment: .leading) {
//                                
//                                Text(card.name)
//                                    .font(.title3)
//                                    .fontWeight(.bold)
//                                
//                                if card.clan == nil {
//                                    Text("Faction: None")
//                                        .font(.caption)
//                                        .fontWeight(.medium)
//                                } else {
//                                    Text("Faction: \(card.clan!)")
//                                        .font(.caption)
//                                        .fontWeight(.medium)
//                                }
//                                Text("Max Copies: \(card.copies ?? 1) ")
//                                    .font(.caption)
//                                    .fontWeight(.medium)
//                                
//                                Text("Card Set: \(card.card_set)")
//                                    .font(.caption)
//                                    .fontWeight(.medium)
//                                
//                                Text("Card Stack: \(card.card_stack.capitalized)")
//                                    .font(.caption)
//                                    .fontWeight(.medium)
//                                                   
//                                if card.card_type == ["attack"] || card.card_type == ["reaction"] {
//                                    ForEach(card.card_type, id: \.self) { type in
//                                        Text("Type: \(type!.capitalized)")
//                                            .font(.caption)
//                                            .fontWeight(.medium)
//                                    }
//                                }
//                            }
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
//                        }
                    }
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationTitle("Add Cards")
            .searchable(text: $searchText, prompt: "Search Cards")
            .frame(maxWidth: .infinity)
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

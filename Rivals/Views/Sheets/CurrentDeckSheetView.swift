//
//  CurrentDeckSheetView.swift
//  Rivals
//
//  Created by Cody hancock on 2/9/25.
//

import SwiftUI

struct CurrentDeckSheetView: View {
    
    @ObservedObject var viewModel: NewDeckViewModel
    var cards: [Card]
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            List {
                Section(header: Text("Current Deck Cards")) {
                    ForEach(viewModel.newDeckDict.keys.sorted(), id: \.self) { cardName in
                        let maxCopies = maxCopiesAllowed(for: cardName)
                        let card = cards.first(where: {$0.name == cardName})
                        EditCellView(
                            card: card!,
                            qty: Binding(
                                get: { viewModel.newDeckDict[cardName, default: 0] },
                                set: { newValue in
                                    viewModel.newDeckDict[cardName] = newValue
                                    if (newValue == 0) {
                                        viewModel.newDeckDict.removeValue(forKey: cardName)
                                        if (viewModel.leaderCard == cardName) {
                                            viewModel.leaderCard = ""
                                            viewModel.hasLeader = false
                                        }
                                    }
                                }
                            ),
                            factionTotal: $viewModel.factionTotal,
                            libraryTotal: $viewModel.libraryTotal,
                            leaderCard: $viewModel.leaderCard,
                            hasLeader: $viewModel.hasLeader,
                            maxQty:maxCopies
                        )
                        .alignmentGuide(.listRowSeparatorLeading) { ViewDimensions in
                            return ViewDimensions[.listRowSeparatorLeading] - 35
                        }
                        .listRowBackground(Color.gray)
                        
                    }
                }
            }
            .scrollContentBackground(.hidden)
        }
    }
}

// TODO: REFACTOR - this is currently repeated code from the EditDeckView, add as a helper function instead
extension CurrentDeckSheetView {
    private func maxCopiesAllowed(for cardName: String) -> Int {
        if let card = cards.first(where: {$0.name == cardName }) {
            if card.card_stack == "faction" || card.card_stack == "agenda" || card.card_stack == "haven" {
                return 1
            } else {
                return 3
            }
        }
        return 3
    }
}

//
//  EditDeckView.swift
//  Rivals
//
//  Created by Cody hancock on 8/14/24.
//

import SwiftUI
import SwiftData

struct FuckedEditDeckView: View {
    
    @EnvironmentObject var viewModel: NewDeckViewModel
    @Query(sort: \Card.id) private var cards: [Card]
    
    @State private var showSaveModel = false
    @State private var showAllCards = false
    @State private var cardList: [String: Int]
    @State private var showAlert: AlertItem? = nil
    
    
    let deck: DecksResponseData?
    
    init(deck:DecksResponseData? = nil) {
        self.deck = deck
        _cardList = State(initialValue: deck!.card_list ?? [:])
        
    }
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                BackgroundView()
                
                VStack {
                    
                    // DECK INFO VIEW
                    DeckInfoView(factionTotal: viewModel.factionTotal, libraryTotal: viewModel.libraryTotal, leaderCard: viewModel.leaderCard, havenCard: viewModel.havenCard, agendaCard: viewModel.agendaCard)
                    
                    
                    List(cards.filter { cardList[$0.name] != nil }, id: \.self) { card in
                        let maxCopies = maxCopiesAllowed(for: card.name)
                        
                        EditCellView(
                            card: card,
                            qty: Binding(
                                get: { cardList[card.name, default: 0] },
                                set: { newValue in
                                    cardList[card.name] = newValue
                                    if (newValue == 0) {
                                        cardList.removeValue(forKey: card.name)
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
                    .scrollContentBackground(.hidden)
                
                    // BOTTOM BUTTONS LAYOUT STACK
                    HStack {
                        
                        // TODO: make it so that the name and clan auto-populate on NameDeckView or create a new one for update specifically
                        Button {
                            showSaveModel.toggle()
                            showAlert = AlertContext.saveSuccess
                            viewModel.updateDeck(existingDeck: deck!)
                            
                        } label: {
                            Text("Update")
                                .frame(width: 140, height: 35)
                                .background(.blue)
                                .foregroundStyle(.white)
                                .cornerRadius(10)
                                .padding(.vertical)
                        }
                    
                        Button {
                            showAllCards.toggle()
                        } label: {
                            Text("Show All Cards")
                                .frame(width: 140, height: 35)
                                .background(.orange)
                                .foregroundStyle(.white)
                                .cornerRadius(10)
                                .padding(.vertical)
                        }
//                    Sheet for displaying all cards over 'EditDeck' View
                        .sheet(isPresented: $showAllCards) {
                            
                            AllCardsSheetView(deck: deck!, cardList: $cardList)
                                .alignmentGuide(.listRowSeparatorLeading) { ViewDimensions in
                                    return ViewDimensions[.listRowSeparatorLeading] - 35
                                }
                        }
                        .presentationDetents([.fraction(0.75)])
                        .presentationDragIndicator(.visible)
                        .presentationBackground(.ultraThinMaterial)
                    }
                    .alert(item: $showAlert) { alertItem in
                        Alert(title: alertItem.title,
                              message: alertItem.message,
                              dismissButton: alertItem.dismissButton)
                    }

                }
                
            }
        }
        .navigationTitle("Edit \(deck!.deck_name)")
        .onChange(of: cardList) {
            deck!.card_list = cardList
        }
        .onAppear {
            if let userDeck = deck {
                viewModel.factionTotal = userDeck.faction_total
                viewModel.libraryTotal = userDeck.library_total
                viewModel.leaderCard = userDeck.deck_leader ?? "-"
                viewModel.agendaCard = userDeck.deck_agenda ?? "-"
                viewModel.havenCard = userDeck.deck_haven ?? "-"
            }
        }
        
    }
}


extension FuckedEditDeckView {
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

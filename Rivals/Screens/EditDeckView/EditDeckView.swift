import SwiftUI
import SwiftData

struct EditDeckView: View {
    @ObservedObject var viewModel: NewDeckViewModel
    var existingDeck: DecksResponseData
    @Query(sort: \Card.id) private var cards: [Card]  // Fetch all available cards
    
    @State private var searchText: String = ""
    @State private var showAllCards: Bool = false
    @State private var showSaveConfirmation = false
    
    init(viewModel: NewDeckViewModel, existingDeck: DecksResponseData) {
        self.viewModel = viewModel
        self.existingDeck = existingDeck
        
        // Load existing deck data into the ViewModel
        viewModel.deckName = existingDeck.deck_name
        viewModel.newDeckDict = existingDeck.card_list ?? [:]
        viewModel.leaderCard = existingDeck.deck_leader ?? ""
        viewModel.hasLeader =   !viewModel.leaderCard.isEmpty
        viewModel.havenCard = existingDeck.deck_haven ?? ""
        viewModel.agendaCard = existingDeck.deck_agenda ?? ""
        viewModel.factionTotal = existingDeck.faction_total
        viewModel.libraryTotal = existingDeck.library_total
    }
    
    var filteredCards: [Card] {
        guard !searchText.isEmpty else { return cards }
        return cards.filter {
            $0.name.localizedCaseInsensitiveContains(searchText) ||
            $0.card_type.contains { $0?.lowercased().contains(searchText.lowercased()) ?? false }
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                BackgroundView()
                
                VStack {
                    // Editable Deck Name
                    TextField("Deck Name", text: $viewModel.deckName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    // Deck Summary
                    DeckInfoView(factionTotal: viewModel.factionTotal,
                                 libraryTotal: viewModel.libraryTotal,
                                 leaderCard: viewModel.leaderCard,
                                 havenCard: viewModel.havenCard,
                                 agendaCard: viewModel.agendaCard)

                    // List of Cards in Deck
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

                    // Searchable Card List (to add new cards)
//                    TextField("Search Cards", text: $searchText)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                        .padding()
//                    
//                    List(filteredCards, id: \.self) { card in
//                        HStack {
//                            Text(card.name)
//                            Spacer()
//                            
//                            if (viewModel.newDeckDict[card.name] ?? 0) < 1 {
//                                Button("Add") {
//                                    viewModel.newDeckDict[card.name] = 1
//                                    if (card.card_stack == "faction") {
//                                        viewModel.factionTotal += 1
//                                    } else {
//                                        viewModel.libraryTotal += 1
//                                    }
//                                }
//                                .buttonStyle(.bordered)
//                            }
//                        }
//                    }
//                    .scrollContentBackground(.hidden)

                    
                    HStack {
                        // Show All Cards Button
                        Button {
                            showAllCards.toggle()
                        } label: {
                            Text("All Cards")
                                .frame(width: 140, height: 35)
                                .background(.orange)
                                .foregroundStyle(.primary)
                                .cornerRadius(10)
                                .padding(.vertical)
                        }
                        // Save Button
                        Button {
                            showSaveConfirmation = true
                        } label: {
                            Text("Save Changes")
                                .frame(width: 140, height: 35)
                                .background(.blue)
                                .foregroundStyle(.primary)
                                .cornerRadius(10)
                                .padding(.vertical)
                                .alert("Confirm Save", isPresented: $showSaveConfirmation) {
                                    Button("Cancel", role: .cancel) {}
                                    Button("Save") {
                                        viewModel.updateDeck(existingDeck: existingDeck)
                                    }
                                } message: {
                                    Text("Are you sure you want to save the changes to this deck?")
                                }
                        }
                        
//                        Button("Save Changes") {
//                            showSaveConfirmation = true
//                        }
//                        .buttonStyle(.borderedProminent)
//                        .padding()
//                        .alert("Confirm Save", isPresented: $showSaveConfirmation) {
//                            Button("Cancel", role: .cancel) {}
//                            Button("Save") {
//                                viewModel.updateDeck(existingDeck: existingDeck)
//                            }
//                        } message: {
//                            Text("Are you sure you want to save the changes to this deck?")
//                        }
                    }
                }
            }
            .navigationTitle("Edit Deck")
            .sheet(isPresented: $showAllCards) {
                AllCardsSheetView(viewModel: viewModel, cards: cards)
            }
        }
    }
}


extension EditDeckView {
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

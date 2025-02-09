import SwiftUI
import SwiftData

struct ver1EditDeckView: View {
    @ObservedObject var viewModel: NewDeckViewModel
    var existingDeck: DecksResponseData
    @Query(sort: \Card.id) private var cards: [Card]  // Fetch all available cards
    
    @State private var searchText: String = ""
    @State private var showSaveConfirmation = false
    
    init(viewModel: NewDeckViewModel, existingDeck: DecksResponseData) {
        self.viewModel = viewModel
        self.existingDeck = existingDeck
        
        // Load existing deck data into the ViewModel
        viewModel.deckName = existingDeck.deck_name
        viewModel.newDeckDict = existingDeck.card_list ?? [:]
        viewModel.leaderCard = existingDeck.deck_leader ?? ""
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
                            HStack {
                                Text(cardName)
                                Spacer()
                                if let card = cards.first(where: { $0.name == cardName }) {
                                    // Enforce Faction Card Limit
                                    if card.card_stack == "faction" {
                                        Stepper("Copies: \(viewModel.newDeckDict[cardName] ?? 0)",
                                                value: Binding(
                                                    get: { viewModel.newDeckDict[cardName] ?? 0 },
                                                    set: { viewModel.newDeckDict[cardName] = min($0, 1) } // Max 1 for faction
                                                ), in: 0...1)
                                        LeaderButton(hasLeader: $viewModel.hasLeader, leaderCard: $viewModel.leaderCard, card: card)
                                    } else {
                                        // Enforce Library Card Limit (Max 3)
                                        Stepper("Copies: \(viewModel.newDeckDict[cardName] ?? 0)",
                                                value: Binding(
                                                    get: { viewModel.newDeckDict[cardName] ?? 0 },
                                                    set: { viewModel.newDeckDict[cardName] = min($0, 3) } // Max 3 for library
                                                ), in: 0...3)
                                    }
                                }
                            }
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                let cardName = Array(viewModel.newDeckDict.keys.sorted())[index]
                                viewModel.newDeckDict.removeValue(forKey: cardName)
                            }
                        }
                    }
                }

                // Searchable Card List (to add new cards)
                TextField("Search Cards", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                List(filteredCards, id: \.self) { card in
                    HStack {
                        Text(card.name)
                        Spacer()
                        if card.card_stack == "faction" {
                            if (viewModel.newDeckDict[card.name] ?? 0) < 1 {
                                Button("Add") {
                                    viewModel.newDeckDict[card.name] = 1
                                }
                                .buttonStyle(.bordered)
                            }
                            LeaderButton(hasLeader: $viewModel.hasLeader, leaderCard: $viewModel.leaderCard, card: card)
                        } else {
                            if (viewModel.newDeckDict[card.name] ?? 0) < 3 {
                                Button("Add") {
                                    let currentCount = viewModel.newDeckDict[card.name] ?? 0
                                    viewModel.newDeckDict[card.name] = min(currentCount + 1, 3)
                                }
                                .buttonStyle(.bordered)
                            }
                        }
                    }
                }

                // Save Changes Button
                Button("Save Changes") {
                    showSaveConfirmation = true
                }
                .buttonStyle(.borderedProminent)
                .padding()
                .alert("Confirm Save", isPresented: $showSaveConfirmation) {
                    Button("Cancel", role: .cancel) {}
                    Button("Save") {
                        viewModel.updateDeck(existingDeck: existingDeck)
                    }
                } message: {
                    Text("Are you sure you want to save the changes to this deck?")
                }
            }
            .navigationTitle("Edit Deck")
        }
    }
}

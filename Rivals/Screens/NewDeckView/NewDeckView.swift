//
//  NewDeckView.swift
//  Rivals
//
//  Created by Cody hancock on 3/23/24.
//

import SwiftUI
import SwiftData

struct NewDeckView: View {
    
    // Variables for NewDeckView
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var viewModel: NewDeckViewModel
    @Query(sort: \Card.id) private var cards: [Card]
    
    @State private var clanClicked = false
    @State private var showSaveDeck = false
    @State private var showClanFilter = false
    @State private var showSaveButton = false
    
    
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
    
    
    var initialDeck: DecksResponseData?
        
    
    // Change Navigation Title font color, Search Bar Background color and font colors
    init(initialDeck: DecksResponseData? = nil) {
        self.initialDeck = initialDeck
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.label]
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .systemBackground
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .label
    }
    
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                // BACKGROUND COLOR VIEW
                BackgroundView()
                
                //  STACK HOLDING DECK CARD COUNTS; FactionTotal, LibrayTotal...
                VStack {
                    HStack {
                        
                        Text("Faction Cards: \(viewModel.factionTotal)/7")
                            .font(.headline)
                            .foregroundStyle(.primary)
                        
                        Text("Library Cards:\(viewModel.libraryTotal)/40")
                            .font(.headline)
                            .foregroundStyle(.primary)
                    }
                    
                    HStack {
                        Text("Leader: ")
                            .font(.subheadline)
                            .foregroundStyle(.primary)
                        Text(viewModel.leaderCard)
                            .font(.caption)
                            .foregroundStyle(.primary)
                        
                        Text("Haven: ")
                            .font(.subheadline)
                            .foregroundStyle(.primary)
                        Text(viewModel.havenCard)
                            .font(.caption)
                            .foregroundStyle(.primary)
                        
                        Text("Agenda: ")
                            .font(.subheadline)
                            .foregroundStyle(.primary)
                        Text(viewModel.agendaCard)
                            .font(.caption)
                            .foregroundStyle(.primary)
                    }
                    
                    VStack(spacing: .none) {
                        HStack {
                            
                            Button {
                                showClanFilter.toggle()
                            } label: {
                                Text("Filter by Clan")
                                    .frame(width: 140, height: 35)
                                    .background(.orange)
                                    .foregroundStyle(.primary)
                                    .cornerRadius(10)
                                    .padding(.vertical)
                            }
                            .sheet(isPresented: $showClanFilter) {
                                ClanFilterListView(searchText: $searchText, clanClicked: $clanClicked, showClanFilter: $showClanFilter)
                                    .presentationDetents([.fraction(0.75)])
                                    .presentationDragIndicator(.visible)
                                    .presentationBackground(.ultraThinMaterial)
                            }
                            
                            if viewModel.newDeckDict.isEmpty != true {
                                // ALL CURRENT CARDS IN NEW DECK BUTTON
                                Button {
                                    print("This will show the view of all the cards in the current new deck")
                                } label: {
                                    Text("Deck Cards")
                                        .frame(width: 140, height: 35)
                                        .background(.blue)
                                        .foregroundStyle(.white)
                                        .cornerRadius(10)
                                        .padding(.vertical)
                                    
                                }
                            }
                        }
                        if viewModel.newDeckDict.isEmpty != true {
                            // SAVE BUTTON
                            Button {
                                
                                showSaveDeck.toggle()
                                
                            } label: {
                                Text("Save New Deck")
                                    .frame(width: 140, height: 35)
                                    .background(.blue)
                                    .foregroundStyle(.white)
                                    .cornerRadius(10)
                                    .padding(.vertical)
                            }
                            // SAVE DECK MODAL - TAKES UP 40% (.40) OF THE SCREEN
                            .sheet(isPresented: $showSaveDeck) {
                                NameDeckView()
                                    .presentationDetents([.fraction(0.40)])
                                    .presentationDragIndicator(.visible)
                                    .presentationBackground(.ultraThinMaterial)
                            }
                        }
                    }
                    
                    List(filteredCards, id: \.self) { card in
                        NewDeckListCell(newDeckDict: $viewModel.newDeckDict, 
                                        libraryTotal: $viewModel.libraryTotal,
                                        factionTotal: $viewModel.factionTotal,
                                        leaderCard: $viewModel.leaderCard,
                                        hasLeader: $viewModel.hasLeader,
                                        card: card)
                            .alignmentGuide(.listRowSeparatorLeading) { ViewDimensions in
                                return ViewDimensions[.listRowSeparatorLeading] - 35
                            }
                            .listRowBackground(Color.gray)
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Deck Creator")
            .searchable(text: $searchText, prompt: "Search Cards")
            .onAppear {
                if let deck = initialDeck {
                    // Pre-populate with deck data
                    viewModel.newDeckDict = deck.card_list ?? [:]
                    viewModel.leaderCard = deck.deck_leader ?? ""
                    viewModel.havenCard = deck.deck_haven ?? ""
                    viewModel.agendaCard = deck.deck_agenda ?? "" 
                    viewModel.factionTotal = deck.faction_total
                    viewModel.libraryTotal = deck.library_total
                }
            }
        }
    }
}

#Preview {
    NewDeckView()
        .modelContainer(for: [Card.self])
}

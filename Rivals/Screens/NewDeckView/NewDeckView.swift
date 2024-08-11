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
    @State private var havenCard: String = ""
    @State private var agendaCard: String = ""
    
    // Search bar functionallity
    @State private var searchText: String = ""
    var filteredCards: [Card] {
        guard !searchText.isEmpty else { return cards }
        return cards.filter {
            $0.id.localizedCaseInsensitiveContains(searchText) || // search by id
            $0.clan?.localizedCaseInsensitiveContains(searchText) ?? false || // search by clan
            $0.card_type.compactMap { $0?.lowercased() }.contains { $0.contains(searchText.lowercased())} || // search by cardType
            $0.attack.compactMap {$0?.lowercased() }.contains { $0.contains(searchText.lowercased())} // search by attack
        }
    }
        
    
    // Change Navigation Title font color, Search Bar Background color and font colors
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .white
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .black
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
                            .foregroundStyle(.white)
                        
                        Text("Library Cards:\(viewModel.libraryTotal)/40")
                            .font(.headline)
                            .foregroundStyle(.white)
                    }
                    
                    HStack {
                        Text("Leader: ")
                            .font(.subheadline)
                            .foregroundStyle(.white)
                        Text(viewModel.leaderCard)
                            .font(.caption)
                            .foregroundStyle(.white)
                        
                        Text("Haven: ")
                            .font(.subheadline)
                            .foregroundStyle(.white)
                        Text(havenCard)
                            .font(.caption)
                            .foregroundStyle(.white)
                        
                        Text("Agenda: ")
                            .font(.subheadline)
                            .foregroundStyle(.white)
                        Text(agendaCard)
                            .font(.caption)
                            .foregroundStyle(.white)
                    }
                    
                    HStack {
                        
                        Button {
                            showClanFilter.toggle()
                        } label: {
                            Text("Filter by Clan")
                                .frame(width: 140, height: 35)
                                .background(.secondary)
                                .foregroundStyle(.white)
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
                            .sheet(isPresented: $showSaveDeck) {
                                NameDeckView()
                                    .presentationDetents([.fraction(0.40)])
                                    .presentationDragIndicator(.visible)
                                    .presentationBackground(.ultraThinMaterial)
                            }
                        }
                        
                    }
                    
                    List(filteredCards, id: \.self) { card in
                        NewDeckListCell(newDeckDict: $viewModel.newDeckDict, libraryTotal: $viewModel.libraryTotal, factionTotal: $viewModel.factionTotal, leaderCard: $viewModel.leaderCard, hasLeader: $viewModel.hasLeader, card: card)
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
        }
    }
}

#Preview {
    NewDeckView()
        .modelContainer(for: [Card.self])
}

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
    @Environment(\.modelContext) private var modelContext // TODO: Is this even needed??
    @EnvironmentObject var viewModel: NewDeckViewModel
    @Query(sort: \Card.id) private var cards: [Card]
    
    @State private var clanClicked = false
    @State private var showSaveDeck = false
    @State private var showClanFilter = false
    @State private var showSaveButton = false
    @State private var showMyDeckSheet = false
    
    
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
    
        
    // Change Navigation Title font color, Search Bar Background color and font colors
    init() {
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
                    
                    DeckInfoView(factionTotal: viewModel.factionTotal, libraryTotal: viewModel.libraryTotal, leaderCard: viewModel.leaderCard, havenCard: viewModel.havenCard, agendaCard: viewModel.agendaCard)
                    
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
                                    showMyDeckSheet.toggle()
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
                    // TODO: Create a allcardscell view 
                    List(filteredCards, id: \.self) { card in
                        HStack {
                            AsyncImage(url: URL(string: card.imageURL)) { image in
                                image
                                    .resizable()
                            } placeholder: {
                                Text("Loading...")
                                    .foregroundStyle(.white)
                            }
                            .frame(width: 100, height: 150)
                            
                            VStack(alignment: .leading) {
                                
                                Text(card.name)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                
                                if card.clan == nil {
                                    Text("Faction: None")
                                        .font(.caption)
                                        .fontWeight(.medium)
                                } else {
                                    Text("Faction: \(card.clan!)")
                                        .font(.caption)
                                        .fontWeight(.medium)
                                }
                                Text("Max Copies: \(card.copies ?? 1) ")
                                    .font(.caption)
                                    .fontWeight(.medium)
                                
                                Text("Card Set: \(card.card_set)")
                                    .font(.caption)
                                    .fontWeight(.medium)
                                
                                Text("Card Stack: \(card.card_stack.capitalized)")
                                    .font(.caption)
                                    .fontWeight(.medium)
                                
                                if card.card_type == ["attack"] || card.card_type == ["reaction"] {
                                    ForEach(card.card_type, id: \.self) { type in
                                        Text("Type: \(type!.capitalized)")
                                            .font(.caption)
                                            .fontWeight(.medium)
                                    }
                                }
                            }
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
                    }
                    .scrollContentBackground(.hidden)
                    
                    //                    List(filteredCards, id: \.self) { card in
                    //                        NewDeckListCell(newDeckDict: $viewModel.newDeckDict,
                    //                                        libraryTotal: $viewModel.libraryTotal,
                    //                                        factionTotal: $viewModel.factionTotal,
                    //                                        leaderCard: $viewModel.leaderCard,
                    //                                        hasLeader: $viewModel.hasLeader,
                    //                                        card: card)
                    //                            .alignmentGuide(.listRowSeparatorLeading) { ViewDimensions in
                    //                                return ViewDimensions[.listRowSeparatorLeading] - 35
                    //                            }
                    //                            .listRowBackground(Color.gray)
                    //                    }
                    //                }
                    //                .scrollContentBackground(.hidden)
                }
            }
            .navigationTitle("Deck Creator")
            .searchable(text: $searchText, prompt: "Search Cards")
            .sheet(isPresented: $showMyDeckSheet) {
                CurrentDeckSheetView(viewModel: viewModel, cards: cards)
            }
        }
    }
}

#Preview {
    NewDeckView()
        .modelContainer(for: [Card.self])
}

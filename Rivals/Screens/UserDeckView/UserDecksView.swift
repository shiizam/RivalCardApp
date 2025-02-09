//
//  UserDecksView.swift
//  Rivals
//
//  Created by Cody hancock on 2/24/24.
//

import SwiftUI

struct UserDecksView: View {
    
    
    @EnvironmentObject var appState: AppState
    @StateObject private var viewModel: UserDecksViewModel
    
    init() {
        _viewModel = StateObject(wrappedValue: UserDecksViewModel(appState: AppState()))
    }
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                BackgroundView()
                if !viewModel.decks.isEmpty {
                    List {
                        ForEach(viewModel.sections) { section in
                            createFactionSection(section)
                        }
                    }
                    .scrollContentBackground(.hidden)
                } else {
                    Text("No Decks Found")
                        .font(.title)
                        .bold()
                }
                
                
            }
            .navigationTitle("My Decks")
            .onAppear {
                Task {
                    await viewModel.loadDecks()
                   
                    
                }
            }
        }
    }
    
    
    private func createFactionSection(_ section: FactionSection) -> some View {
        Section(header: Text(section.faction.description)) {
            // If the section has clans, create a section for each clan
            if !section.clans.isEmpty {
                ForEach(section.clans) { clanSection in
                    createClanSection(clanSection)
                }
            } else {
                // Handle the Hunter faction case with no clans
                // TODO: i edited the nav link for testing deleted or use after testing
                VStack {
                    ForEach(section.clans.first?.decks ?? []) { deck in
                        NavigationLink(destination: EditDeckView(viewModel: NewDeckViewModel(appState: appState), existingDeck: deck)) {
                            
                            // Conditionally display images based on the deck type
                            if deck.hunter_deck {
                                Image(systemName: "cross.fill")
                                    .foregroundStyle(.blue) // Change color or style if needed
                            } else {
                                Image(systemName: "drop.fill")
                                    .foregroundStyle(.red)
                            }
                            Text(deck.deck_name)
                                .font(.title3)
                                .foregroundColor(.mint)
                        }
                    }
                    .onDelete { indexSet in
                        Task {
                            for index in indexSet {
                                let deck = section.clans.first?.decks[index]
                                if let deckId = deck?.id {
                                    await viewModel.deckToDelete(deckId: deckId)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func createClanSection(_ section: ClanSection) -> some View {
        Section(header: section.clan == .none ? nil : Text(section.clan.description)) {
            ForEach(section.decks) { deck in
//                NavigationLink(destination: FuckedEditDeckView(deck: deck)) {
                NavigationLink(destination: EditDeckView(viewModel: NewDeckViewModel(appState: appState), existingDeck: deck)) {
                    HStack {
                        // Use deck.faction to determine the image
                        Image(systemName: deck.deck_faction == "hunter" ? "cross.fill" : "drop.fill")
                            .foregroundStyle(deck.deck_faction == "hunter" ? .blue : .red)
                        Text(deck.deck_name)
                            .font(.title3)
                            .foregroundColor(.mint)
                    }
                }
            }
            .onDelete { indexSet in
                Task {
                    for index in indexSet {
                        let deck = section.decks[index]
                        await viewModel.deckToDelete(deckId: deck.id)
                    }
                }
            }
        }
    }
}

//
//  UserDecksViewModel.swift
//  Rivals
//
//  Created by Cody hancock on 2/24/24.
//

import SwiftUI


struct FactionSection: Identifiable {
    let id = UUID()
    let faction: Faction
    let clans: [ClanSection]
}

struct ClanSection: Identifiable {
    let id = UUID()
    let clan: Clan
    let decks: [DecksResponseData]
}


final class UserDecksViewModel: ObservableObject {
    
    @Published var decks: [DecksResponseData] = []
    @Published var sections: [FactionSection] = []
    
    
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible())]
    
    
    private var appState: AppState
    
    init(appState: AppState) {
        self.appState = appState
    }
    
    
    private func organizeDecks() {
        print("Organizing decks...")
        var organizedSections: [FactionSection] = []

        // Get unique factions from the decks
        let factions = Set(decks.map { $0.deck_faction })
        
        for faction in factions {
            guard let factionEnum = Faction(rawValue: faction) else { continue }

            if factionEnum == .vampire {
                // Handle vampire factions with clans
                var clans: [ClanSection] = []
                let clanNames = Set(decks.filter { $0.deck_faction == faction }.map { $0.deck_clan })
                
                for clanName in clanNames {
                    let clanEnum = Clan(rawValue: clanName) ?? .none
                    let clanDecks = decks.filter { $0.deck_faction == faction && $0.deck_clan == clanName }
                    
                    // Print the clanDecks for each clan
                    print("Vampire faction: \(factionEnum.description), Clan: \(clanEnum.description)")
                    print("Decks in this clan: \(clanDecks)")
                    
                    if !clanDecks.isEmpty {
                        clans.append(ClanSection(clan: clanEnum, decks: clanDecks))
                    }
                }
                
                if !clans.isEmpty {
                    organizedSections.append(FactionSection(faction: factionEnum, clans: clans))
                }
            } else {
                // Handle factions without clans (e.g., hunter)
                let factionDecks = decks.filter { $0.deck_faction == faction }
                
                // Print the factionDecks for hunters
                print("Hunter faction: \(factionEnum.description)")
                print("Decks in this faction: \(factionDecks)")
                
                // Ensure only decks with clan "none" are considered
                let filteredDecks = factionDecks.filter { $0.deck_clan == "none" }
                
                if !filteredDecks.isEmpty {
                    organizedSections.append(FactionSection(faction: factionEnum, clans: [
                        ClanSection(clan: .none, decks: filteredDecks)
                    ]))
                }
            }
        }
        
        self.sections = organizedSections
        print("Organized sections: \(organizedSections)")
    }
    
    
    func loadDecks() async {
        do {
            let fetchedDecks = try await appState.fetchDecks()
            DispatchQueue.main.async {
                self.decks = fetchedDecks
                self.organizeDecks()
            }
        } catch {
            print("loadDecks Func: Failed to fetch decks: \(error.localizedDescription)")
        }
    }
    
    func deckToDelete(deckId: Int) async {
        do {
            try await appState.deleteDeck(deckId: deckId)
            if let index = decks.firstIndex(where: { $0.id == deckId }) {
                print("Removing deck at index \(index)")
                DispatchQueue.main.async {
                    self.decks.remove(at: index)
//               print("Decks after removal: \(self.decks)") //TODO: Remove
                }
            }
            await loadDecks()
        } catch {
            print("Func deckToDelete - Failed to delete deck: \(error)")
        }
    }
}

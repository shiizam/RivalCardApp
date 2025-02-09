//
//  NewDeckViewModel.swift
//  Rivals
//
//  Created by Cody hancock on 8/9/24.
//

import SwiftUI
import Combine

final class NewDeckViewModel: ObservableObject {
    
    @Published var copyAmount: Int = 0
    @Published var newDeckDict: [String: Int] = [:]
    @Published var libraryTotal: Int = 0
    @Published var factionTotal: Int = 0
    @Published var leaderCard: String = ""
    @Published var hasLeader: Bool = false
    @Published var showSaveDeck: Bool = false
    @Published var deckName: String = ""
    @Published var isHunter: Bool = false
    @Published var havenCard: String = ""
    @Published var agendaCard: String = ""
    @Published var factionSelection: Faction = .none
    @Published var clanSelection: Clan = .none
    
    
    private var cancellables = Set<AnyCancellable>()
     
    private var appState: AppState
    
    init(appState: AppState, deckName: String? = nil) {
        self.appState = appState
    }
    
    // RESET VIEW TO DEFAULT
    func resetView() {
        deckName = ""
        newDeckDict = [:]
        libraryTotal = 0
        factionTotal = 0
        leaderCard = ""
        havenCard = ""
        agendaCard = ""
        hasLeader = false
        copyAmount = 0
        factionSelection = .none
        clanSelection = .none
    }

    // SAVE DECK FUNCTION
    func saveDeck() {
        
        guard let user = appState.loadUser() else {return}
        
        // Convert enums to strings
        let factionString = factionSelection.rawValue
        let clanString = clanSelection.rawValue
        
        let body: [String: Any] = [
            "user": user.id,
            "deck_name": deckName,
            "card_list": newDeckDict,
            "deck_leader": leaderCard,
            "deck_haven": havenCard,
            "deck_agenda": agendaCard,
            "hunter_deck": isHunter,
            "faction_total": factionTotal,
            "library_total": libraryTotal,
            "deck_faction": factionString,
            "deck_clan": clanString
        ]
        
        // Save to Backend DB
        NetworkManager.shared.makeAuthenticatedRequest(endpoint: "decks/", method: "POST", body: body, responseType: DecksResponseData.self) { result in
            switch result {
            case .success(let responseData):
                self.resetView()
                print("Saved new Deck: \(responseData)")
            case .failure(let error):
                print("Failed to save new deck: \(error)")
            }
            
        }
    }
    
    func updateDeck(existingDeck: DecksResponseData) {
       
        guard let user = appState.loadUser() else {return}
        
        
//        let body: [String: Any] = [
//            "user": user.id,
//            "id": existingDeck.id,
//            "deck_name": existingDeck.deck_name,
//            "card_list": existingDeck.card_list ?? [:],
//            "deck_leader": existingDeck.deck_leader ?? "",
//            "deck_haven": existingDeck.deck_haven ?? "",
//            "deck_agenda": existingDeck.deck_agenda ?? "",
//            "hunter_deck": existingDeck.hunter_deck,
//            "faction_total": existingDeck.faction_total,
//            "library_total": existingDeck.library_total,
//            "deck_faction": existingDeck.deck_faction,
//            "deck_clan": existingDeck.deck_clan
//        ]
        let body: [String: Any] = [
            "user": user.id,
            "id": existingDeck.id,
            "deck_name": deckName,
            "card_list": newDeckDict,
            "deck_leader": leaderCard,
            "deck_haven": havenCard,
            "deck_agenda": agendaCard,
            "hunter_deck": existingDeck.hunter_deck,
            "faction_total": factionTotal,
            "library_total": libraryTotal,
            "deck_faction": existingDeck.deck_faction,
            "deck_clan": existingDeck.deck_clan
        ]
        
        NetworkManager.shared.makeAuthenticatedRequest(endpoint: "decks/\(existingDeck.id)", method: "PUT", body: body, responseType: DecksResponseData.self) { result in
            switch result {
            case .success(let responseData):
                print("Updated Deck: \(responseData)")
            case .failure(let error):
                print("Failed to update deck: \(error)")
            }
        }
        
    }
    
    
}

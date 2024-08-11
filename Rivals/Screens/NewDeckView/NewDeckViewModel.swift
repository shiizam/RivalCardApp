//
//  NewDeckViewModel.swift
//  Rivals
//
//  Created by Cody hancock on 8/9/24.
//

import SwiftUI
import Combine

final class NewDeckViewModel: ObservableObject {
    
    @Published var newDeckDict: [String: Int] = [:]
    @Published var libraryTotal: Int = 0
    @Published var factionTotal: Int = 0
    @Published var leaderCard: String = ""
    @Published var hasLeader: Bool = false
    @Published var showSaveDeck: Bool = false
    @Published var deckName: String = ""
    @Published var isHunter: Bool = false
    
    
    private var cancellables = Set<AnyCancellable>()
     
    private var appState: AppState
    
    init(appState: AppState) {
        self.appState = appState
    }
    func resetView() {
        deckName = ""
        newDeckDict = [:]
        libraryTotal = 0
        factionTotal = 0
        leaderCard = ""
        hasLeader = false
    }

    func saveDeck(deckName: String, newDeckDict: [String: Int], leaderName: String) {
        
        guard let user = appState.loadUser() else {return}
        
        let body: [String: Any] = [
            "user": user.id,
            "deck_name": deckName,
            "card_list": newDeckDict,
            "deck_leader": leaderName
        ]
        
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
    
    
}

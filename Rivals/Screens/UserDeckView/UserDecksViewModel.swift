//
//  UserDecksViewModel.swift
//  Rivals
//
//  Created by Cody hancock on 2/24/24.
//

import SwiftUI


final class UserDecksViewModel: ObservableObject {
    
    
    @Published var decks: [DecksResponseData] = []
    
    
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible())]
    
    private var appState: AppState
    
    init(appState: AppState) {
        self.appState = appState
    }
    
    func loadDecks() async {
        do {
            let fetchedDecks = try await appState.fetchDecks()
            DispatchQueue.main.async {
                self.decks = fetchedDecks
            }
        } catch {
            print("loadDecks Func: Failed to fetch decks: \(error.localizedDescription)")
        }
    }
    
}

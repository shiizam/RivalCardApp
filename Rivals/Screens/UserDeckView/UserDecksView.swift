//
//  UserDecksView.swift
//  Rivals
//
//  Created by Cody hancock on 2/24/24.
//

import SwiftUI

struct UserDecksView: View {
    
    @StateObject var viewModel = UserDecksViewModel()
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                BackgroundView()
                
                ScrollView {
             
                    LazyVGrid(columns: viewModel.columns) {
                        ForEach(UserDeckData.userDecks) { deck in
                            UserDecksTitleView(deck: deck)
                                .onTapGesture {
                                    print("tapped")
                                }
                        }
                    }
                    Button {
                        print("tapped")
                    } label: {
                        NewDeckButton(buttonText: "Create New Deck")
                    }
                }
            }
            .navigationTitle("My Decks")
            
        }
    }
}


struct UserDeck: Hashable, Identifiable {
    let id = UUID()
    let name: String
    let cardTotal: String
    let deckLogo: String
}


struct UserDeckData {
    static let sampleUserDeck = UserDeck(name: "MyBrujahDeck", cardTotal: "10", deckLogo: "logo")
    
    static let userDecks = [
        UserDeck(name: "MyFirstDeck", cardTotal: "10", deckLogo: "vtm-bg"),
        UserDeck(name: "MyBrujahDeck", cardTotal: "10", deckLogo: "vtm-bg"),
        UserDeck(name: "MyThinBloodDeck", cardTotal: "10", deckLogo: "vtm-bg"),
        UserDeck(name: "MyTremereDeck", cardTotal: "10", deckLogo: "vtm-bg"),
        UserDeck(name: "MyVentrueDeck", cardTotal: "10", deckLogo: "vtm-bg"),
    ]
    
}

#Preview {
    UserDecksView()
}

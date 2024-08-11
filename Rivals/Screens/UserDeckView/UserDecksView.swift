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
                
                List {
                    ForEach(viewModel.decks, id: \.id) { deck in
                        NavigationLink(destination: DeckView(deck: deck)) {
                            
                            if deck.hunter_deck {
                                Image(systemName: "cross.fill")
                            } else {
                                Image(systemName: "drop.fill")
                                    .foregroundStyle(.red)
                            }
                            
                            Text(deck.deck_name)
                                .font(.title3)
                                .foregroundColor(.mint)
                        }
                        
                    }
                }
               
//                ScrollView {
             
//                    LazyVGrid(columns: viewModel.columns) {
//                        ForEach(viewModel.decks) { deck in
//                            UserDecksTitleView(deck: deck)
//                                .onTapGesture {
//                                    print("tapped")
//                                }
//                        }
//                    }
//                    Button {
//                        print("tapped")
//                    } label: {
//                        NewDeckButton(buttonText: "Create New Deck", buttonColor: Color.gray)
//                    }
//                }
            }
            .scrollContentBackground(.hidden)
            .navigationTitle("My Decks")
            .onAppear {
                Task {
                    await viewModel.loadDecks()
                    print(viewModel.decks)
                }
            }
            .toolbar {
                ToolbarItem {
                    Menu(content: {
                        Text("TEST")
                    }, label: {
                        Image(systemName: "plus.circle")
                    })
                }
            }
            
        }
    }
}


//struct UserDeck: Hashable, Identifiable {
//    let id = UUID()
//    let name: String
//    let cardTotal: String
//    let deckLogo: String
//}
//
//
//struct UserDeckData {
//    static let sampleUserDeck = UserDeck(name: "MyBrujahDeck", cardTotal: "10", deckLogo: "logo")
//    
//    static let userDecks = [
//        UserDeck(name: "MyFirstDeck", cardTotal: "10", deckLogo: "vtm-bg"),
//        UserDeck(name: "MyBrujahDeck", cardTotal: "10", deckLogo: "vtm-bg"),
//        UserDeck(name: "MyThinBloodDeck", cardTotal: "10", deckLogo: "vtm-bg"),
//        UserDeck(name: "MyTremereDeck", cardTotal: "10", deckLogo: "vtm-bg"),
//        UserDeck(name: "MyVentrueDeck", cardTotal: "10", deckLogo: "vtm-bg"),
//    ]
//    
//}

//#Preview {
//    UserDecksView()
//}

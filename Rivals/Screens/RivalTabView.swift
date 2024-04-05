//
//  ContentView.swift
//  Rivals
//
//  Created by Cody hancock on 2/24/24.
//

import SwiftUI


struct RivalTabView: View {
    

    
    var body: some View {
        ZStack {
            
            TabView {
            
                AllCardsView()
                    .tabItem { Label("Cards", systemImage: "lanyardcard") }
                
//                UserDecksView()
                NewDeckView()
                    .tabItem { Label("Decks", systemImage: "bag") }
                
                LoginView()
                    .tabItem { Label("Account", systemImage: "person") }
            }
        }

    }
}

#Preview {
    RivalTabView()
        
}



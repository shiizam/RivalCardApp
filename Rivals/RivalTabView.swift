//
//  ContentView.swift
//  Rivals
//
//  Created by Cody hancock on 2/24/24.
//

import SwiftUI


struct RivalTabView: View {
    
    
    @EnvironmentObject var appState: AppState
    @State private var selectedTab = 0
    
    init() {
        UITabBar.configAppearance()
    }
    
    var body: some View {
        
        
        ZStack {
            
            TabView(selection: $selectedTab) {
            
                AllCardsView()
                    .tabItem { Label("Cards", systemImage: "lanyardcard") }
                    .tag(0)
                
                UserDecksView()
                    .tabItem { Label("My Decks", systemImage: "square.stack") }
                    .tag(1)
                    
                NewDeckView()
                    .tabItem { Label("New Deck", systemImage: "rectangle.stack.fill.badge.plus") }
                    .tag(2)
                
                AccountView()
                    .tabItem { Label("Account", systemImage: "gear") }
                    .tag(3)

            }
            
        }
    }
}

#Preview {
    RivalTabView()
}



//
//  AccountView.swift
//  Rivals
//
//  Created by Cody hancock on 8/4/24.
//

import SwiftUI

struct AccountView: View {
    
    @EnvironmentObject var appState: AppState
    
    var settings: [Setting] = [
        .init(name: "Account Settings", iconName: "gear", color: .purple),
        .init(name: "My Decks", iconName: "lanyardcard", color: .mint)
    ]
    
    
    var body: some View {
            
        NavigationStack {
            ZStack{
                List {
                    Section("Account Settings") {
                        ForEach(settings, id: \.name) { setting in
                            NavigationLink(value: setting) {
                                Label(setting.name, systemImage: setting.iconName)
                                    .foregroundColor(setting.color)
                            }
                        }
                    }

                }
                .navigationTitle("Account")
                .navigationDestination(for: Setting.self) { setting in
                    ZStack {
                        setting.color.ignoresSafeArea()
                        Label(setting.name, systemImage: setting.iconName)
                            .font(.largeTitle).bold()
                    }
                }
                
                Button("Sign Out") {
                    appState.logout()
                }

//                Button("Get Decks") {
//                    appState.fetchDecks()
//                }
            }
        }
    }
}
    

struct Setting: Hashable {
    let name: String
    let iconName: String
    let color: Color
}
    


#Preview {
    AccountView()
}

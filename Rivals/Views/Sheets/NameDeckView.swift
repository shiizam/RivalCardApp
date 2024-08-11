//
//  NameDeckView.swift
//  Rivals
//
//  Created by Cody hancock on 7/29/24.
//

import SwiftUI
import SwiftData

struct NameDeckView: View {
    
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var viewModel: NewDeckViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
            
        VStack {
           Text("Save New Deck")
                .font(.title).bold()
                .padding(.bottom, 20)
            
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text("New Deck Name:")
                        .frame(alignment: .leading)
                        .font(.callout)
                        .foregroundStyle(.black)
                        .padding(.leading)
                    
                    TextField("Enter name...", text: $viewModel.deckName)
                        .frame(width: 200, height: 35)
                        .textFieldStyle(.roundedBorder)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .padding([.leading, .trailing])
                }
                    
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text("Hunter Deck?")
                        .font(.callout)
                        .foregroundStyle(.black)
                
                    Toggle("", isOn: $viewModel.isHunter)
                        .tint(.bloodRed)
                        .labelsHidden()
                        
                }
            }
            
            HStack {
                Button {
                    viewModel.saveDeck(deckName: viewModel.deckName, newDeckDict: viewModel.newDeckDict, leaderName: viewModel.leaderCard)
                    viewModel.showSaveDeck.toggle()
                } label: {
                    Text("Save")
                        .frame(width: 100)
                        .padding()
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Button {
                    viewModel.showSaveDeck.toggle()
                    dismiss()
                   
                } label: {
                    Text("Cancel")
                        .padding()
                        .foregroundColor(.blue)
                        .cornerRadius(10)
                }
            }
        }
    }
}



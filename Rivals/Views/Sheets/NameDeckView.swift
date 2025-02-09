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
    
    var deck: DecksResponseData?
    
   
    
    init(deck: DecksResponseData? = nil) {
        self.deck = deck
        
    }
    
    var body: some View {
            
        VStack {
            Text( "Save New Deck" )
                .font(.title).bold()
                .padding(.bottom, 20)
            
            VStack(alignment: .listRowSeparatorLeading) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("New Deck Name:")
                        .frame(alignment: .leading)
                        .font(.callout)
                        .foregroundStyle(.primary)
                        .padding(.leading)
                    
                    TextField("Enter name...", text: $viewModel.deckName)
                        .frame(width: 245, height: 50)
                        .textFieldStyle(.roundedBorder)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .padding([.leading, .trailing])
                        
                }
                
                HStack{
                    FactionPicker()
                    
                    if viewModel.factionSelection == .vampire {
                        ClanPicker()
                    }
                }
                
                
                    
//                HStack {
//                    
//                    Text("Hunter Deck?")
//                        .font(.callout)
//                        .foregroundStyle(.primary)
//                
//                    Toggle("", isOn: $viewModel.isHunter)
//                        .tint(.bloodRed)
//                        .labelsHidden()
//                        
//                }
//                .padding(.bottom, 10)
            }
            
            HStack {
                Button {

                        viewModel.saveDeck()
                    
                    viewModel.showSaveDeck.toggle()
                } label: {
                    Text(deck == nil ? "Save" : "Update")
                        .frame(width: 100)
                        .padding()
                        .background(.blue)
                        .foregroundColor(.primary)
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



//
//  ClanPicker.swift
//  Rivals
//
//  Created by Cody hancock on 8/13/24.
//

import SwiftUI

struct ClanPicker: View {
    
//    @State private var clanSelection: Clan = .banuHaqim
    @EnvironmentObject var viewModel: NewDeckViewModel
    
    var body: some View {
        VStack {
            
            Text("Select Clan")
                .font(.callout)
                .foregroundStyle(.primary)
            
            Picker("", selection: $viewModel.clanSelection) {
                ForEach(Clan.allCases) { option in
                    Text(option.description)
                        .tag(option)
                }
                
            }
            .pickerStyle(.menu)
            .background(Color(.systemGray6))
            .foregroundStyle(.primary)
            .cornerRadius(8)
            .padding([.leading, .trailing])
        }
        
    }
}

#Preview {
    ClanPicker()
}

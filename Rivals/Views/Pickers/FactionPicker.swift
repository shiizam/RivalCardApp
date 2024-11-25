//
//  FactionPicker.swift
//  Rivals
//
//  Created by Cody hancock on 8/13/24.
//

import SwiftUI

struct FactionPicker: View {
    
    @EnvironmentObject var viewModel: NewDeckViewModel
    
    
    var body: some View {
      
        VStack{
            Text("Select Faction Type")
                .font(.callout)
                .foregroundStyle(.primary)
            
            Picker("", selection: $viewModel.factionSelection) {
                ForEach(Faction.allCases) { option in
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
    FactionPicker()
}

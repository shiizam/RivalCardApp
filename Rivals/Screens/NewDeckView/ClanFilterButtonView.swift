//
//  ClanFilterButtonView.swift
//  Rivals
//
//  Created by Cody hancock on 3/27/24.
//

import SwiftUI

struct ClanFilterButtonView: View {
    @Binding var searchText: String
    @Binding var clanClicked: Bool
    @Binding var showClanFilter: Bool
    
    var clanName: String
    var clanIcon: String
    
    var body: some View {
        Button {
            searchText = clanName
            clanClicked.toggle()
            showClanFilter.toggle()
        } label: {
            
            VStack {
                
                Image(clanIcon)
                    .resizable()
                    .background(.white)
                    .cornerRadius(10)
                    .frame(width: 50, height: 50, alignment: .center)
                
                Text(clanName)
                    .foregroundStyle(.white)
            }
            .frame(width: 115, height: 60)
        }
    }
}


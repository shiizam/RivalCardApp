//
//  ClanFilterButtonView.swift
//  Rivals
//
//  Created by Cody hancock on 3/27/24.
//

import SwiftUI

struct ClanFilterButtonView: View {
    
    var clanName: String
    var clanIcon: String
    
    var body: some View {
        Button {
            print("Tapped")
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

#Preview {
    ClanFilterButtonView(clanName: "Bruha", clanIcon: "clan-banu-haqim")
}

//
//  UserDeckTitleView.swift
//  Rivals
//
//  Created by Cody hancock on 2/24/24.
//

import SwiftUI

struct UserDecksTitleView: View {
    
    let deck: DecksResponseData

    var body: some View {
        ZStack {
            
            VStack {
                
                Image("vtm-bg")
                    .symbolRenderingMode(.multicolor)
                    .resizable()
                    .frame(width: 90, height: 90)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(12)
                
                Text(deck.deck_name)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .scaledToFit()
                    .minimumScaleFactor(0.6)
            }
            .padding()
        }
    }
}

//#Preview {
//    UserDecksTitleView(deck: UserDeckData.sampleUserDeck)
//}

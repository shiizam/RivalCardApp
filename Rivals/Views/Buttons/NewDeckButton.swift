//
//  AddButton.swift
//  Rivals
//
//  Created by Cody hancock on 2/24/24.
//

import SwiftUI


struct NewDeckButton: View {
    var buttonText: LocalizedStringKey
    var buttonColor: Color
    
    var body: some View {
        Text(buttonText)
            .frame(width: 280, height: 50)
            .background(buttonColor)
            .foregroundColor(.black)
            .font(.system(size: 20, weight: .bold, design: .default))
            .cornerRadius(10)
        
    }
}

#Preview {
    NewDeckButton(buttonText: "Placeholder", buttonColor: .blue)
}

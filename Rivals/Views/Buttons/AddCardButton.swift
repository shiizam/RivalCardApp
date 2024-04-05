//
//  AddCardButton.swift
//  Rivals
//
//  Created by Cody hancock on 3/27/24.
//

import SwiftUI

struct AddCardButton: View {
    var body: some View {
        Image(systemName: "plus.rectangle.fill")
            .resizable()
            .frame(width: 35, height: 25)
    }
}

#Preview {
    AddCardButton()
}

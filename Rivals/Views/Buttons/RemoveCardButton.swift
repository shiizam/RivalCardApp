//
//  RemoveCardButton.swift
//  Rivals
//
//  Created by Cody hancock on 3/29/24.
//

import SwiftUI

struct RemoveCardButton: View {
    var body: some View {
        Image(systemName: "minus.rectangle.fill")
            .resizable()
            .frame(width: 40, height: 35)
    }
}

#Preview {
    RemoveCardButton()
}

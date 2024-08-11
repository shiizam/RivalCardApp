//
//  RemoveLeaderButton.swift
//  Rivals
//
//  Created by Cody hancock on 8/1/24.
//

import SwiftUI

struct EmptyLeaderButton: View {
    var body: some View {
        Image(systemName: "star")
            .resizable()
            .frame(width: 40, height: 35)
    }
}

#Preview {
    EmptyLeaderButton()
}

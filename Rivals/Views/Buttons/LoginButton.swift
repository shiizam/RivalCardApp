//
//  LoginButton.swift
//  Rivals
//
//  Created by Cody hancock on 8/3/24.
//

import SwiftUI

struct LoginButton: View {
    var body: some View {
        Text("Login")
            .frame(width: 280, height: 50)
            .background(.blue)
            .foregroundColor(.black)
            .font(.system(size: 20, weight: .bold, design: .default))
            .cornerRadius(10)
    }
}

#Preview {
    LoginButton()
}

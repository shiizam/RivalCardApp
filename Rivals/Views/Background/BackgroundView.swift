//
//  BackgroundView.swift
//  Rivals
//
//  Created by Cody hancock on 2/24/24.
//

import SwiftUI


struct BackgroundView: View {
    
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color("GradientTop"), Color("GradientBottom")]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
        .ignoresSafeArea()
    }
}

//
//  InputPlaceholder+Ext.swift
//  Rivals
//
//  Created by Cody hancock on 8/6/24.
//

import SwiftUI

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
        ZStack(alignment: alignment) {
            // Show placeholder only when shouldShow is true
            if shouldShow {
                placeholder()
                    .transition(.opacity)
                    .animation(.easeInOut, value: shouldShow)
            }
            self
        }
    }
}

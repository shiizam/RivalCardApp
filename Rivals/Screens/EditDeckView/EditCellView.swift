//
//  EditCellView.swift
//  Rivals
//
//  Created by Cody hancock on 10/8/24.
//

import SwiftUI

struct EditCellView: View {
    
    var cardName: String
    @Binding var qty: Int
    var maxQty: Int
    
    
    var body: some View {
        HStack {
            Text(cardName)
                .font(.headline).bold()
                .foregroundStyle(.primary)

            
            Spacer()
            
            HStack {
               
                RemoveCardButton()
                    .onTapGesture {
                        if qty > 0 {
                            qty -= 1
                        }
                    }
                
                Text("Qty: \(qty)")
                    .font(.headline)
                    .foregroundStyle(.primary)
                if qty < maxQty {
                    AddCardButton()
                        .onTapGesture {
                            qty += 1
                        }
                }
            }
        }
    }
}

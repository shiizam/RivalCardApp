////
////  DeckCellView.swift
////  Rivals
////
////  Created by Cody hancock on 8/11/24.
////
//
//import SwiftUI
//
//struct DeckCellView: View {
//    
//    let imgUrl: String
//    let cardName: String
//    let qty: Int
//    @State private var isEdit = false
//    
//    var body: some View {
//        HStack {
//            AsyncImage(url: URL(string: imgUrl)) { image in
//                image
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 75, height: 95)
//                    .cornerRadius(10)
//                
//            } placeholder: {
//                Rectangle()
//                    .foregroundColor(.gray)
//                    .frame(width: 75, height: 95)
//            }
//            
//            VStack(alignment: .leading) {
//                Text(cardName)
//                    .font(.title3).bold()
//                    .foregroundStyle(.primary)
//                Text("Qty: \(qty)")
//                    .font(.headline)
//                    .foregroundStyle(.primary)
//            }
//        }
//        .padding(.vertical, 5)
//    }
//}
//

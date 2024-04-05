//
//  NewDeckListCell.swift
//  Rivals
//
//  Created by Cody hancock on 3/29/24.
//

import SwiftUI

struct NewDeckListCell: View {
    @State private var copyAmount = 0
    @Binding var newDeckDict: [String: Int]
    @Binding var libraryTotal: Int
    @Binding var factionTotal: Int
    
    var card: Card
    var body: some View{
        
        HStack {
            AsyncImage(url: URL(string: card.imageURL)) { image in
                image
                    .resizable()
            } placeholder: {
                Text("Loading...")
                    .foregroundStyle(.white)
            }
            .frame(width: 100, height: 150)
           // LEFT SIDE CELL
            HStack {
                VStack(alignment: .leading) {
                    
                    Text(card.name)
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    if card.clan == nil {
                        Text("Faction: None")
                    } else {
                        Text("Faction: \(card.clan!)")
                            .font(.caption)
                            .fontWeight(.medium)
                    }
                    Text("Copies: \(card.copies ?? 1) ")
                        .font(.caption)
                        .fontWeight(.medium)
                    
                    Text("Card Set: \(card.card_set)")
                        .font(.caption)
                        .fontWeight(.medium)
                    
                    Text("Card Stack: \(card.card_stack.capitalized)")
                        .font(.caption)
                        .fontWeight(.medium)
                }
                
                Spacer()
                
                // RIGHT SIDE OF CELL
                VStack(alignment: .trailing) {
                    
                    if copyAmount < card.copies ?? 1 {
                        
                        Text("Deck: \(copyAmount)")
                            .foregroundStyle(.white)
                        
                        if factionTotal != 7 && card.card_stack == "faction" {
                            AddCardButton()
                                .onTapGesture {
                                    copyAmount += 1
                                    newDeckDict[card.name] = copyAmount
                                    factionTotal += 1
                                }
                            
                        } else if card.card_stack == "faction" && factionTotal == 7 {
                            Text("Faction Card Total Reached!")
                                .foregroundStyle(.white)
                        }
                        
                        if libraryTotal != 40 && card.card_stack == "library"{
                            AddCardButton()
                                .onTapGesture {
                                    copyAmount += 1
                                    newDeckDict[card.name] = copyAmount
                                    libraryTotal += 1
                                }
                            
                        } else if card.card_stack == "library" && libraryTotal == 40 {
                            Text("Library Card Total Reached!")
                                .foregroundStyle(.white)
                        }
                        
                    } else {
                        Text("Max: \(copyAmount)")
                            .foregroundStyle(.white)
                        
                        
                        RemoveCardButton()
                            .onTapGesture {
                                copyAmount -= 1
                                newDeckDict[card.name] = copyAmount
                                if copyAmount == 0 {
                                    newDeckDict[card.name] = nil
                                }

                                if card.card_stack == "faction" {
                                    factionTotal -= 1
                                } else {
                                    libraryTotal -= 1
                                }
                            }
                    }
                }
            }
        }
    }
}



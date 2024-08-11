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
    @Binding var leaderCard: String
    @Binding var hasLeader: Bool
    
    let factionMax = 7
    let libraryMax = 40
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
                            .font(.caption)
                            .fontWeight(.medium)
                    } else {
                        Text("Faction: \(card.clan!)")
                            .font(.caption)
                            .fontWeight(.medium)
                    }
                    Text("Max Copies: \(card.copies ?? 1) ")
                        .font(.caption)
                        .fontWeight(.medium)
                    
                    Text("Card Set: \(card.card_set)")
                        .font(.caption)
                        .fontWeight(.medium)
                    
                    Text("Card Stack: \(card.card_stack.capitalized)")
                        .font(.caption)
                        .fontWeight(.medium)
                                       
                    if card.card_type == ["attack"] || card.card_type == ["reaction"] {
                        ForEach(card.card_type, id: \.self) { type in
                            Text("Type: \(type!.capitalized)")
                                .font(.caption)
                                .fontWeight(.medium)
                        }
                    }
                }
                
                Spacer()
                
                // RIGHT SIDE OF CELL
                VStack(alignment: .trailing) {
                    
                    if copyAmount < card.copies ?? 1 {

                        //FACTION CARD BUTTON LOGIC
                        if card.card_stack == "faction" {
                            if hasLeader != true && newDeckDict.contains(where: {$0.key == leaderCard}) {
                                EmptyLeaderButton()
                                    .onTapGesture {
                                        hasLeader = true
                                        leaderCard = card.name
                                    }
                            } else if hasLeader && card.name == leaderCard {
                                FilledLeaderButton()
                                    .onTapGesture {
                                        hasLeader = false
                                        leaderCard = ""
                                    }
                            }
                            
                            
                            if factionTotal != factionMax {
                                Text("Deck: \(copyAmount)")
                                    .foregroundStyle(.white)
                                
                                AddCardButton()
                                    .onTapGesture {
                                        copyAmount += 1
                                        newDeckDict[card.name] = copyAmount
                                        factionTotal += 1
                                    }
                                
                            } else if card.card_stack == "faction" && factionTotal == factionMax {
                                Text("Max Reached!")
                                    .foregroundStyle(.white)
                            }
                            
                        // LIBRARY CARD BUTTON LOGIC
                        } else if card.card_stack == "library" {
                            if libraryTotal != libraryMax {
                                
                                Text("Deck: \(copyAmount)")
                                    .foregroundStyle(.white)
                                
                                AddCardButton()
                                    .onTapGesture {
                                        copyAmount += 1
                                        newDeckDict[card.name] = copyAmount
                                        libraryTotal += 1
                                    }
                                    
                                if copyAmount >= 1 {
                                    RemoveCardButton()
                                        .onTapGesture {
                                            copyAmount -= 1
                                            newDeckDict[card.name] = copyAmount
                                            libraryTotal -= 1
                                            
                                            if copyAmount == 0 {
                                                newDeckDict[card.name] = nil
                                            }
                                        }
                                }
                                
                            } else if card.card_stack == "library" && libraryTotal == libraryMax {
                                Text("Max Reached!")
                                    .foregroundStyle(.white)
                            }
                        }
                    } else {
                        if card.card_stack == "faction" {
                            if hasLeader && leaderCard == card.name {
                                FilledLeaderButton()
                                    .onTapGesture {
                                        hasLeader = false
                                        leaderCard = ""
                                    }
                            } else {
                                EmptyLeaderButton()
                                    .onTapGesture {
                                        hasLeader = true
                                        leaderCard = card.name
                                    }
                            }
                        }
                        
                        
                        Text("Max: \(copyAmount)")
                            .foregroundStyle(.white)
                        
                        // RemoveButton visible when individual card count is > 1 in newDeckDict
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

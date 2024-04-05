//
//  NewDeckView.swift
//  Rivals
//
//  Created by Cody hancock on 3/23/24.
//

import SwiftUI
import SwiftData

struct NewDeckView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Card.id) private var cards: [Card]
    @State private var showClanFilter = false
    @State private var libraryTotal = 0
    @State private var factionTotal = 0
    
    @State private var newDeckDict: [String: Int] = [:]
    
    // Search bar functionallity
    @State private var searchText: String = ""
    var filteredCards: [Card] {
        guard !searchText.isEmpty else { return cards }
        return cards.filter { $0.id.localizedCaseInsensitiveContains(searchText) }
    }
        
    
    // Change Navigation Title font color
    init() { UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white] }
    
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                BackgroundView()
                
                VStack {
                    
                    HStack {
                        Text("Faction Cards: \(factionTotal)/7")
                            .font(.headline)
                            .foregroundStyle(.white)
                        
                        Text("Library Cards:\(libraryTotal)/40")
                            .font(.headline)
                            .foregroundStyle(.white)
                    }
                    Button {
                        if showClanFilter == false {
                            showClanFilter = true
                        } else {
                            showClanFilter = false
                        }
                    } label: {
                        Text("Filter by Clan")
                            .frame(width: 140, height: 25)
                            .background(.secondary)
                            .foregroundStyle(.white)
                            .cornerRadius(10)
                            .padding(.vertical)
                    }
                    if showClanFilter == true {
                        ClanFilterListView()

                    } else {
                    
                        List(filteredCards, id: \.self) { card in
                            NewDeckListCell(newDeckDict: $newDeckDict, libraryTotal: $libraryTotal, factionTotal: $factionTotal, card: card)
                                .alignmentGuide(.listRowSeparatorLeading) { ViewDimensions in
                                    return ViewDimensions[.listRowSeparatorLeading] - 35
                                }
//                            .listStyle(.grouped)
//                            .listRowBackground(Color.clear)
                        }
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Deck Creator")
            .searchable(text: $searchText, prompt: "Search Cards")
        }
    }
}

#Preview {
    NewDeckView()
        .modelContainer(for: [Card.self])
}

//struct SingleCopy: View {
//    
////    @State var selection = 0
//    @Binding var deckCopies: [String: Int]
//    var cardID: String
//    
//    
//    init(deckCopies: Binding<[String: Int]>, cardID: String) {
//        _deckCopies = deckCopies
//        self.cardID = cardID
//        // Set background color of picker
//        UISegmentedControl.appearance().backgroundColor = .gray.withAlphaComponent(0.15)
//        // Changes the color of the selected item
//        UISegmentedControl.appearance().selectedSegmentTintColor = .selectedItem
//        // Changes the text color for the selected item
//        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
//        // Changes the text color for the non-selected items
//        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
//    }
//   
//    
//    var body: some View {
//        Picker("Select # of copies", selection: Binding<Int?>(
//            get: { deckCopies[cardID] },
//            set: { newValue in
//                if let newValue = newValue {
//                    deckCopies[cardID] = newValue
//                }
//            }
//        )) {
//            Text("0").tag(0)
//            Text("1").tag(1)
//        }
//        .frame(width:100, height: 25)
//        .pickerStyle(.segmented)
//        .onAppear {
//            if deckCopies[cardID] == nil {
//                deckCopies[cardID] = 0
//            }
//        }
//        Text("\(selection)")
//            .foregroundStyle(.white)
//    }
//}

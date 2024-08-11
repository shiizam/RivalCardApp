//
//  SwiftUIView.swift
//  Rivals
//
//  Created by Cody hancock on 3/22/24.
//

import SwiftUI
import SwiftData

struct AllCardsView: View {
    
       
    @Environment(\.modelContext) private var modelContext
    @AppStorage("lastFetched") private var lastFetched: Double = Date.now.timeIntervalSince1970
    @Query(sort: \Card.id) private var cards: [Card]
    
    @State private var searchText: String = ""
    @State private var path = NavigationPath()
    
    var filteredCards: [Card] {
        guard !searchText.isEmpty else { return cards }
        return cards.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }

    
    var body: some View {
        
        NavigationStack(path: $path) {
            ZStack {
                
                BackgroundView()
                
                List(filteredCards, id: \.id) { card in
                    HStack {
                        
                        Spacer()
                        
                        VStack {
                            AsyncImage(url: URL(string: card.imageURL)) { image in
                                image
                                    .resizable()
                                    .cornerRadius(10)
                            } placeholder: {
                                
                                Rectangle()
                                    .foregroundStyle(.secondary)
                            }
                            .frame(width: 275, height: 400)
                            
                            Text(card.name)
                                .font(.title3)
                                .fontWeight(.medium)
                                .foregroundStyle(.white)
                        }
                        
                        Spacer()
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("VTM: Cards")
            .task {
                do {
                    if hasExceededLimit() || cards.isEmpty {
                        clearCardData()
                        try await fetchCardData()
                    }
                } catch {
                    print(error)
                }
            }
            .searchable(text: $searchText, prompt: "Search Cards")
            
        }
    }
}

#Preview {
    AllCardsView()
        .modelContainer(for: [Card.self])
}

extension AllCardsView {
    
    func fetchCardData() async throws {
        let url = URL(string: "http://10.0.0.244:8000/cards")!
      
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let cards = try JSONDecoder().decode([Card].self, from: data)
        
        cards.forEach { modelContext.insert($0) }
        
        lastFetched = Date.now.timeIntervalSince1970
    }
    
    
    func hasExceededLimit() -> Bool {
        let timeLimit = 86400
        let currentTime = Date.now
        let lastFetchedTime = Date(timeIntervalSince1970: lastFetched)
        
        guard let differenceInMins = Calendar.current.dateComponents([.second], from: lastFetchedTime, to: currentTime).second else {
            return false
        }
        
        return differenceInMins >= timeLimit
    }
    
    func clearCardData() {
        _ = try? modelContext.delete(model: Card.self)
    }
}

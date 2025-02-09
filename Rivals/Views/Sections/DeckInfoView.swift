//
//  DeckLeaderHavenAgendaContainer.swift
//  Rivals
//
//  Created by Cody hancock on 2/3/25.
//

import SwiftUI

struct DeckInfoView: View {
    var factionTotal: Int = 0
    var libraryTotal: Int = 0
    
    var leaderCard: String = "-"
    var havenCard: String = "-"
    var agendaCard: String = "-"
    
    var body: some View {
        VStack {
            
            HStack {
                
                Text("Faction Cards: \(factionTotal)/7")
                    .font(.headline)
                    .foregroundStyle(.primary)
                
                Text("Library Cards:\(libraryTotal)/40")
                    .font(.headline)
                    .foregroundStyle(.primary)
            }
            
            HStack {
                Text("Leader: ")
                    .font(.subheadline)
                    .foregroundStyle(.primary)
                Text(leaderCard)
                    .font(.caption)
                    .foregroundStyle(.primary)
                
                Text("Haven: ")
                    .font(.subheadline)
                    .foregroundStyle(.primary)
                Text(havenCard)
                    .font(.caption)
                    .foregroundStyle(.primary)
                
                Text("Agenda: ")
                    .font(.subheadline)
                    .foregroundStyle(.primary)
                Text(agendaCard)
                    .font(.caption)
                    .foregroundStyle(.primary)
            }
        }
    }
}

#Preview {
    DeckInfoView(factionTotal: 0, libraryTotal: 0, leaderCard: "LeaderPlace", havenCard: "HavenPlace", agendaCard: "AgendaPlace")
}

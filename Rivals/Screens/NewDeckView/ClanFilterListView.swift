//
//  ClanFilterListView.swift
//  Rivals
//
//  Created by Cody hancock on 3/28/24.
//

import SwiftUI

struct ClanFilterListView: View {
    
    @StateObject var gridColumns = ClansGridViewModel()
    
    
    var body: some View {
        LazyVGrid(columns: gridColumns.columns, spacing: 20) {
            ClanFilterButtonView(clanName: "Banu Haqim", clanIcon: "clan-banu-haqim")
            ClanFilterButtonView(clanName: "Brujah", clanIcon: "clan-brujah")
            ClanFilterButtonView(clanName: "Caitiff", clanIcon: "clan-caitiff")
            ClanFilterButtonView(clanName: "Faithful", clanIcon: "clan-faithful")
            ClanFilterButtonView(clanName: "Gangrel", clanIcon: "clan-gangrel")
            ClanFilterButtonView(clanName: "Hecata", clanIcon: "clan-hecata")
            ClanFilterButtonView(clanName: "Inquisitive", clanIcon: "clan-inquisitive")
            ClanFilterButtonView(clanName: "Lasombra", clanIcon: "clan-lasombra")
            ClanFilterButtonView(clanName: "Malkavian", clanIcon: "clan-malkavian")
            ClanFilterButtonView(clanName: "Ministry", clanIcon: "clan-ministry")
            ClanFilterButtonView(clanName: "Nosferatu", clanIcon: "clan-nosferatu")
            ClanFilterButtonView(clanName: "Ravnos", clanIcon: "clan-ravnos")
            ClanFilterButtonView(clanName: "Salubri", clanIcon: "clan-salubri")
            ClanFilterButtonView(clanName: "Thin-blood", clanIcon: "clan-thinblood")
            ClanFilterButtonView(clanName: "Toreador", clanIcon: "clan-toreador")
            ClanFilterButtonView(clanName: "Tremere", clanIcon: "clan-tremere")
            ClanFilterButtonView(clanName: "Tzimisce", clanIcon: "clan-tzimisce")
            ClanFilterButtonView(clanName: "Ventrue", clanIcon: "clan-ventrue")
        }
    }
}

#Preview {
    ClanFilterListView()
}

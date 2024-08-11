//
//  ClanFilterListView.swift
//  Rivals
//
//  Created by Cody hancock on 3/28/24.
//

import SwiftUI

struct ClanFilterListView: View {
    
    @StateObject var gridColumns = ClansGridViewModel()
    @Binding var searchText: String
    @Binding var clanClicked: Bool
    @Binding var showClanFilter: Bool
    
    
    var body: some View {
        LazyVGrid(columns: gridColumns.columns, spacing: 20) {
            ClanFilterButtonView(searchText: $searchText, clanClicked: $clanClicked, showClanFilter: $showClanFilter, clanName: "Banu Haqim", clanIcon: "clan-banu-haqim")
            ClanFilterButtonView(searchText: $searchText, clanClicked: $clanClicked, showClanFilter: $showClanFilter, clanName: "Brujah", clanIcon: "clan-brujah")
            ClanFilterButtonView(searchText: $searchText, clanClicked: $clanClicked, showClanFilter: $showClanFilter, clanName: "Caitiff", clanIcon: "clan-caitiff")
            ClanFilterButtonView(searchText: $searchText, clanClicked: $clanClicked, showClanFilter: $showClanFilter, clanName: "Faithful", clanIcon: "clan-faithful")
            ClanFilterButtonView(searchText: $searchText, clanClicked: $clanClicked, showClanFilter: $showClanFilter, clanName: "Gangrel", clanIcon: "clan-gangrel")
            ClanFilterButtonView(searchText: $searchText, clanClicked: $clanClicked, showClanFilter: $showClanFilter, clanName: "Hecata", clanIcon: "clan-hecata")
            ClanFilterButtonView(searchText: $searchText, clanClicked: $clanClicked, showClanFilter: $showClanFilter, clanName: "Inquisitive", clanIcon: "clan-inquisitive")
            ClanFilterButtonView(searchText: $searchText, clanClicked: $clanClicked, showClanFilter: $showClanFilter, clanName: "Lasombra", clanIcon: "clan-lasombra")
            ClanFilterButtonView(searchText: $searchText, clanClicked: $clanClicked, showClanFilter: $showClanFilter, clanName: "Malkavian", clanIcon: "clan-malkavian")
            ClanFilterButtonView(searchText: $searchText, clanClicked: $clanClicked, showClanFilter: $showClanFilter, clanName: "Ministry", clanIcon: "clan-ministry")
            ClanFilterButtonView(searchText: $searchText, clanClicked: $clanClicked, showClanFilter: $showClanFilter, clanName: "Nosferatu", clanIcon: "clan-nosferatu")
            ClanFilterButtonView(searchText: $searchText, clanClicked: $clanClicked, showClanFilter: $showClanFilter, clanName: "Ravnos", clanIcon: "clan-ravnos")
            ClanFilterButtonView(searchText: $searchText, clanClicked: $clanClicked, showClanFilter: $showClanFilter, clanName: "Salubri", clanIcon: "clan-salubri")
            ClanFilterButtonView(searchText: $searchText, clanClicked: $clanClicked, showClanFilter: $showClanFilter, clanName: "Thin-blood", clanIcon: "clan-thinblood")
            ClanFilterButtonView(searchText: $searchText, clanClicked: $clanClicked, showClanFilter: $showClanFilter, clanName: "Toreador", clanIcon: "clan-toreador")
            ClanFilterButtonView(searchText: $searchText, clanClicked: $clanClicked, showClanFilter: $showClanFilter, clanName: "Tremere", clanIcon: "clan-tremere")
            ClanFilterButtonView(searchText: $searchText, clanClicked: $clanClicked, showClanFilter: $showClanFilter, clanName: "Tzimisce", clanIcon: "clan-tzimisce")
            ClanFilterButtonView(searchText: $searchText, clanClicked: $clanClicked, showClanFilter: $showClanFilter, clanName: "Ventrue", clanIcon: "clan-ventrue")
        }
    }
}

//#Preview {
//    ClanFilterListView()
//}

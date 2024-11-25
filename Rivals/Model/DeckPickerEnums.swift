//
//  DeckPickerEnums.swift
//  Rivals
//
//  Created by Cody hancock on 8/13/24.
//

import Foundation


enum Clan: String, CaseIterable, Identifiable, CustomStringConvertible {
    case none
    case banuHaqim
    case brujah
    case caitiff
    case faithful
    case gangrel
    case hecata
    case inquisitive
    case lasombra
    case malkavian
    case minitstry
    case noseferatu
    case ravnos
    case salubri
    case thinBlood
    case toreador
    case tremere
    case tzimisce
    case ventrue
    
    var id: Self { self }
    
    var description: String {
        switch self {
        case .none:
            return ""
        case .banuHaqim:
            return "Banu Haqim"
        case .brujah:
            return "Brujah"
        case .caitiff:
            return "Caitiff"
        case .faithful:
            return "Faithful"
        case .gangrel:
            return "Gangrel"
        case .hecata:
            return "Hecata"
        case .inquisitive:
            return "Inquisitive"
        case .lasombra:
            return "Lasombra"
        case .malkavian:
            return "Malkavian"
        case .minitstry:
            return "Ministry"
        case .noseferatu:
            return "Noseferatu"
        case .ravnos:
            return "Ravnos"
        case .salubri:
            return "Salubri"
        case .thinBlood:
            return "Thin-blood"
        case .toreador:
            return "Toreador"
        case .tremere:
            return "Tremere"
        case .tzimisce:
            return "Tzimisce"
        case .ventrue:
            return "Ventrue"
        }
    }
}

enum Faction: String, CaseIterable, Identifiable, CustomStringConvertible {
    case none
    case vampire
    case hunter
    case werewolf
    
    var id: Self {self}
    
    var description: String {
        switch self {
        case .none:
            return "No Selection"
        case .vampire:
            return "Vampire"
        case .hunter:
            return "Hunter"
        case .werewolf:
            return "Werewolf"
        }
    }
}

//
//  common.swift
//  Rivals
//
//  Created by Cody hancock on 3/6/24.
//

import Foundation


typealias CardId = String

enum CityCardType: String {
    case title              = "title"
    case event              = "event"
    case ongoing            = "ongoing"
    case mortal             = "mortal"
    case antagonist         = "antagonist"
    case retainer           = "retainer"
    case citzen             = "citizen"
    case secondInquistion   = "second inquisition"
}

enum LibraryCardType: String {
    case onePerPlayer           = "1 per player"
    case twoActions             = "2 actions"
    case action                 = "action"
    case alchemy                = "alchemy"
    case animal                 = "animal"
    case attack                 = "attack"
    case conspiracy             = "conspiracy"
    case event                  = "event"
    case ghoul                  = "ghoul"
    case influenceModifiew      = "influence modifier"
    case ongoing                = "ongoing"
    case reaction               = "reaction"
    case relic                  = "relic"
    case ritual                 = "ritual"
    case scheme                 = "scheme"
    case special                = "special"
    case title                  = "title"
    case trap                   = "trap"
    case unhostedAction         = "unhosted action"
    case unique                 = "unique"
}

enum AttackType: String {
    case mental     = "mental"
    case physical   = "physical"
    case ranged     = "ranged"
    case social     = "social"
}

enum CardSet: String {
    case core               = "Core"
    case bloodAndAlchemy    = "Blood & Alchemy"
    case promo              = "Promo"
    case wolfAndRat         = "Wolf & Rat"
    case shadowsAndShrouds  = "Shadows & Shrouds"
    case heartOfEurope      = "Heart of Europe"
    case conclave22         = "Conclave 22"
    case dragonAndRogue     = "Dragon & Rogue"
    case justiceAndMercy    = "Justice & Mercy"
    case huntersAndHunted   = "Hunters & Hunted"
    case princePack1        = "Prince Pack 1"
}

//enum Clan: CaseIterable, Identifiable, CustomStringConvertible {
//    case banuHaqim
//    case brujah
//    case caitiff
//    case faithful
//    case gangrel
//    case hecata
//    case inquisitive
//    case lasombra
//    case malkavian
//    case minitstry
//    case noseferatu
//    case ravnos
//    case salubri
//    case thinBlood
//    case toreador
//    case tremere
//    case tzimisce
//    case ventrue
//    
//    var id: Self { self }
//    
//    var description: String {
//        switch self {
//        case .banuHaqim:
//            return "Banu Haqim"
//        case .brujah:
//            return "Brujah"
//        case .caitiff:
//            return "Caitiff"
//        case .faithful:
//            return "Faithful"
//        case .gangrel:
//            return "Gangrel"
//        case .hecata:
//            return "Hecata"
//        case .inquisitive:
//            return "Inquisitive"
//        case .lasombra:
//            return "Lasombra"
//        case .malkavian:
//            return "Malkavian"
//        case .minitstry:
//            return "Ministry"
//        case .noseferatu:
//            return "Noseferatu"
//        case .ravnos:
//            return "Ravnos"
//        case .salubri:
//            return "Salubri"
//        case .thinBlood:
//            return "Thin-blood"
//        case .toreador:
//            return "Toreador"
//        case .tremere:
//            return "Tremere"
//        case .tzimisce:
//            return "Tzimisce"
//        case .ventrue:
//            return "Ventrue"
//        }
//    }
//    
//    
//}

enum Discipline: String {
    case animalism = "animalism"
    case auspex = "auspex"
    case bloodSorcery = "blood sorcery"
    case celerity = "celerity"
    case dominate = "dominate"
    case fortitude = "fortitude"
    case obfuscate = "obfuscate"
    case oblivion = "oblivion"
    case potence = "potence"
    case presence = "presence"
    case protean = "protean"
    case thinBloodAlchemy = "thin-blood alchemy"
    case beastWhisperer = "beast whisperer"
    case library = "library"
    case senseTheUnnatural = "sense the unnatural"
    case repelTheUnnatural = "repel the unnatural"
    case thwartTheUnnatural = "thwart the unnatural"
    case global = "global"
}
    
enum Illustrator: String {
    case none = ""
    case adelijahOcampo = "Adelijah Ocampo"
    case amyWilkins = "Amy Wilkins"
    case anaHorbunova = "Ana Horbunova"
    case anastasiiaHorbunova = "Anastasiia Horbunova"
    case coldCastleStudios = "Cold Castle Studios"
    case darkoStojanovic = "Darko Stojanovic"
    case dawnNique = "Dawn Nique"
    case drewTucker = "Drew Tucker"
    case felipeGaona = "Felipe Gaona"
    case harveyBunda = "Harvey Bunda"
    case ireneFrancisco = "Irene Francisco"
    case jánosOrbán = "János Orbán"
    case joshuaEsmeralda = "Joshua Esmeralda"
    case joyceMaureira = "Joyce Maureira"
    case krasenMaximov = "Krasen Maximov"
    case maraMirandaEscota = "Mara Miranda-Escota"
    case marcoPrimo = "Marco Primo"
    case theCreationStudio = "The Creation Studio"
    case timothyTerrenalAndHarveyBunda = "Timothy Terrenal and Harvey Bunda"
    case timothyTerrenal = "Timothy Terrenal"
    case micoDimagiba = "Mico Dimagiba"
}

enum Cardpool: String {
  case hunter = "hunter"
  case vampire = "vampire"
  case hunterAndVampire = "hunter and vampire"
}

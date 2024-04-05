//
//  fetchCardData.swift
//  Rivals
//
//  Created by Cody hancock on 3/14/24.
//

import SwiftUI
import SwiftData









// TODO: MOVE THIS INTO SEPERATE FILE AND MAKE IT MORE GENERIC SO IT CAN BE REUSED FOR THE OTHER API CALLS
/* Function for getting data from my backend (NOTE: this is not for images, though the imageURL pointers are a part of this data) */
//func fetchCardData() {
//    var cards: [Card] = []
//    
////   guard let url = URL(string: "http://127.0.0.1:8000/cards/") else {return}
//   guard let url = URL(string: "http://10.0.0.244:8000/cards/") else {return}
//    URLSession.shared.dataTask(with: url) { data, _, error in
//        if let data = data {
//            do {
//                let decodedData = try JSONDecoder().decode([Card].self, from: data)
//                cards = decodedData
//                print("Success")
//                print(cards)
//            } catch {
//                print("Error decoding: \(error)")
//            }
//        } else if let error = error {
//            print("Error Fetching data: \(error)")
//        }
//    }
//    .resume()
//}

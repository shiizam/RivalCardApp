//
//  SendPostRequest.swift
//  Rivals
//
//  Created by Cody hancock on 7/29/24.
//

import Foundation

func postDeckRequest(deckName: String, newDeckDict: [String: Int], leaderName: String) {
    // Define the URL
    guard let url = URL(string: "http://10.0.0.244:8000/decks/") else { return }

    
    let body: [String: Any] = [
        
        "user": 1, // TODO: this needs to be dynamic
        "deck_name": deckName,
        "card_list": newDeckDict,
        "deck_leader": leaderName
    ]
    


    guard let jsonData = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed) else {
        return print("Uh-oh")
    }
    
    // Create a URLRequest object
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    // Set the HTTP body
    request.httpBody = jsonData

    // Create the URLSession data task
    let task = URLSession.shared.dataTask(with: request) { data, _, error in
        guard let data = data, error == nil else {
            return
        }
        
        do {
            let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            print("Success \(response)")
        }
        catch {
            print(error)
        }
        
    }

    // Start the data task
    task.resume()
}

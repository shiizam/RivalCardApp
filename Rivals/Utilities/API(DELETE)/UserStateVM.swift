//
//  loginPostRequest.swift
//  Rivals
//
//  Created by Cody hancock on 8/2/24.
//


//
//  SendPostRequest.swift
//  Rivals
//
//  Created by Cody hancock on 7/29/24.
//

import Foundation
import SwiftUI


//enum UserStateError: Error {
//    case signInError, signOutError
//}
//
//class UserStateVM: ObservableObject {
//    //    @EnvironmentObject var vm: UserStateViewModel
//        
//    @Published var isLoggedIn = false
//    @Published var isBusy = false
//    
//    
//    
//    func signIn() async -> Result<Bool, UserStateError> {
//        isBusy = true
//        do {
//            try await Task.sleep(nanoseconds: 1_000_000_000)
//            isLoggedIn = true
//            isBusy = false
//            return .success(true)
//        }
//        catch {
//            isBusy = false
//            return .failure(.signInError)
//        }
//    }
//    
//    func signOut() async -> Result<Bool, UserStateError> {
//        isBusy = true
//        do {
//            try await Task.sleep(nanoseconds: 1_000_000_000)
//            isLoggedIn = false
//            isBusy = false
//            return .success(true)
//        } catch {
//            isBusy = false
//            return .failure(.signOutError)
//        }
//    }
//    
//    let loginEndpoint = "http://10.0.0.244:8000/login/"
//    
//    
//    func loginPostRequest(username: String, password: String) {
//        
//        // Define the URL
//        guard let url = URL(string: loginEndpoint) else { return }
//
//        // TODO: FIX THIS
//        let body: [String: Any] = [
//            "username": username,
//            "password": password
//        ]
//        
//        guard let jsonData = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed) else {
//            return print("Uh-oh")
//        }
//        
//        // Create a URLRequest object
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        // Set the HTTP body
//        request.httpBody = jsonData
//
//        // Create the URLSession data task
//        let task = URLSession.shared.dataTask(with: request) { data, _, error in
//            guard let data = data, error == nil else {
//                return
//            }
//            
//            do {
//                
//                let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                print("Success \(response)")
//                
//            }
//            catch {
//                print(error)
//            }
//            
//        }
//
//        // Start the data task
//        task.resume()
//    }
//}

//
//  AppState.swift
//  Rivals
//
//  Created by Cody hancock on 8/6/24.
//

import Combine
import SwiftUI



enum RegisteredStatus {
    case none, success, failure
}


class AppState: ObservableObject {
    
    @EnvironmentObject var vm: NewDeckViewModel
    
    @Published var isAuthenticated: Bool = false
    @Published var token: String?
    @Published var user: User?
    @Published var registrationStatus: RegisteredStatus = .none
    

    
    private var cancellable: AnyCancellable?
    
    init() {
        self.token = KeychainHelper.shared.get("authToken")
        self.isAuthenticated = (token != nil)
        self.user = loadUser()
        
        //TODO: Remove this
        print("AppState initialized. Token: \(String(describing: token)), isAuthenticated: \(isAuthenticated), User: \(String(describing: user))")

    }
    
    func fetchDecks() async throws -> [DecksResponseData] {
        return try await withCheckedThrowingContinuation { continuation in
            NetworkManager.shared.makeAuthenticatedRequest(endpoint: "decks/", method: "GET", responseType: [DecksResponseData].self) { result in
                switch result {
                case .success(let responseData):
                    print("Fetch Decks Reponse: \(responseData)")
                    continuation.resume(returning: responseData)
                case .failure(let error):
                    continuation.resume(throwing: error)
                    print("Fetch Decks Error: \(error)")
                }
            }
        }
    }
    
    
    func register(email: String, username: String, password: String, confirmPassword: String) {
        NetworkManager.shared.register(email: email, username: username, password: password, confirmPassword: confirmPassword) { [weak self] result in
            switch result {
            case .success:
                self?.registrationStatus = .success
                print("Account Registered Successfully")
                
            case .failure(let error):
                self?.registrationStatus = .failure
                print("Account registeration failed with the following error: \(error)")
            }
        }
    }

   
    func login(username: String, password: String) {
        NetworkManager.shared.login(username: username, password: password) { [weak self] result in
            switch result {
            case .success(let responseData):
                let token = responseData.token
                KeychainHelper.shared.save(token, forKey: "authToken")
                self?.token = token
                self?.user = responseData.user
                self?.saveUser(user: responseData.user)
                self?.isAuthenticated = true
            case .failure(let error):
                print("Login failed with error: \(error.localizedDescription)")
            }
        }
    }
    
    func logout() {
        KeychainHelper.shared.delete("authToken")
        self.token = nil
        self.user = nil
        self.isAuthenticated = false
        deleteUser()
    }
    
    private func saveUser(user: User) {
        if let encodedUser = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encodedUser, forKey: "user")
        }
    }
    
    func loadUser() -> User? {
        if let userData = UserDefaults.standard.data(forKey: "user"),
           let user = try? JSONDecoder().decode(User.self, from: userData) {
            return user
        }
        return nil
    }
    
    private func deleteUser() {
        UserDefaults.standard.removeObject(forKey: "user")
    }
    

}

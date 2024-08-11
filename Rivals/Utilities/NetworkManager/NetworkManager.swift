//
//  NetworkManager.swift
//  Rivals
//
//  Created by Cody hancock on 8/5/24.
//

import SwiftUI
import Combine


class NetworkManager: ObservableObject {
    
    static let shared = NetworkManager()
    
    @Published var responseData: LoginResponseData?
    
    var cancellable: AnyCancellable?
    
    // CREATE AUTHENTICATED REQUEST
    private func createAuthenticatedRequest(endpoint: String, method: String = "GET", token: String, body: [String: Any]? = nil) -> URLRequest? {
        guard let url = URL(string: "http://10.0.0.244:8000/\(endpoint)") else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Token \(token)", forHTTPHeaderField: "Authorization")
        
        
        
        if let body = body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        
        return request
    }
    
    // MAKE AUTHENTICATED REQUEST
    func makeAuthenticatedRequest<T: Decodable>(endpoint: String, method: String = "GET", body: [String: Any]? = nil, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let token = KeychainHelper.shared.get("authToken"), !token.isEmpty else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        guard let request = createAuthenticatedRequest(endpoint: endpoint, method: method, token: token, body: body) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: request)
            .map { output in
                // Log the raw response data
                if let jsonString = String(data: output.data, encoding: .utf8) {
                    print("Raw JSON response: \(jsonString)")
                } else {
                    print("Failed to decode raw data to string.")
                }
                return output.data
            }
            .decode(type: responseType, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { result in
                switch result {
                case .finished:
                    print("Request successfully made!")
                case .failure(let error):
                    print("Request failed @NetworkManager. The following error occurred: \(error)")
                    completion(.failure(error))
                }
                
            }, receiveValue: { response in
                completion(.success(response))
            })
    }
    
    // LOGIN REQUEST
    private func createPOSTRequest(username: String, password: String) -> URLRequest? {
        guard let url = URL(string: "http://10.0.0.244:8000/login/") else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "username": username,
            "password": password
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        return request
    }
    
    // CREATE REGISTRATION REQUEST
    private func createRegistrationPostRequest(email: String, username: String, password: String, confirmPassword: String) -> URLRequest? {
        // Url that the request will be sent to
        guard let url = URL(string: "http://10.0.0.244:8000/register/") else {
            return nil
        }
        
        // Create Request with appropriate headers
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        // Create body that will be sent
        let body: [String: Any] = [
            "email": email,
            "username": username,
            "password": password,
            "confirm_password": confirmPassword
        ]
        
        // Create JSON version of body
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        // Return request
        return request
        
    }
    
    // CREATE LOGIN
    func login(username: String, password: String, completion: @escaping (Result<LoginResponseData, Error>) -> Void) {
        guard let request = createPOSTRequest(username: username, password: password) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        
        cancellable = URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: LoginResponseData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { result in
                switch result {
                case .finished:
                    print("Network request finished successfully.")
                case .failure(let error):
                    print("Network request failed with error: \(error)")
                    completion(.failure(error))
                }
            }, receiveValue: { response in
                completion(.success(response))
            })
    }
    
    
    func register(email: String, username: String, password: String, confirmPassword: String, completion: @escaping (Result<Void, Error>) -> Void) {
        
        guard let request = createRegistrationPostRequest(email: email, username: username, password: password, confirmPassword: confirmPassword) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { result in
                switch result {
                case .finished:
                    print("Registeration request finished Successfully")
                case .failure(let error):
                    print("Registration request failed with the following error: \(error)")
                    completion(.failure(error))
                }
            }, receiveValue: { _ in
                
            })
    }
}

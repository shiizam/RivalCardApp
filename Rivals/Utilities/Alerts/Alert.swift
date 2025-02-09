//
//  Alert.swift
//  Rivals
//
//  Created by Cody hancock on 2/24/24.
//

import SwiftUI


struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct AlertContext {
    // MARK: - MISC ALERTS
    static let saveSuccess       = AlertItem(title: Text("Deck Updated!"),
                                             message: Text("Deck updates have been saved."),
                                             dismissButton: .default(Text("OK")))
    
    static let saveConfirmation  = AlertItem(title: Text("Confirm Save"),
                                             message: Text("Are you sure you want to save the changes to this deck?"),
                                             dismissButton: .default(Text("OK")))
    
    //MARK: - NETWORK ALERTS
    static let invalidData       = AlertItem(title: Text("Server Error"),
                                             message: Text("The data received from the server was invalid. Please contact support."),
                                             dismissButton: .default(Text("OK")))
    
    static let invalidResponse   = AlertItem(title: Text("Server Response Error"),
                                             message: Text("Invalid response from the server. Please try again later or contact support."),
                                             dismissButton: .default(Text("OK")))
    
    static let invalidURL        = AlertItem(title: Text("Server Error"),
                                             message: Text("There was an issue connecting to the server. If this persists, please contact support."),
                                             dismissButton: .default(Text("OK")))
    
    static let unableToComplete  = AlertItem(title: Text("Server Error"),
                                             message: Text("Unable to complete your request at this time. Please check your internet connection"),
                                             dismissButton: .default(Text("OK")))
    
    
    //MARK: - NETWORK ALERTS
    static let invalidForm        = AlertItem(title: Text("Invalid Form"),
                                             message: Text("First, Last and/or Email input is empty. Please verify that all inputs are filled out "),
                                             dismissButton: .default(Text("OK")))
    
    static let invalidEmail        = AlertItem(title: Text("Invalid Email"),
                                             message: Text("Please verify that you are using a valid email"),
                                             dismissButton: .default(Text("OK")))

    static let userSaveSuccess     = AlertItem(title: Text("Profile Saved"),
                                             message: Text("Your profile information was successfully saved."),
                                             dismissButton: .default(Text("OK")))
    
    static let invalidUserData     = AlertItem(title: Text("Profile Error"),
                                             message: Text("There was an error saving or retrieving your profile."),
                                             dismissButton: .default(Text("OK")))

}



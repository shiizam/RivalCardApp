//
//  RivalsApp.swift
//  Rivals
//
//  Created by Cody hancock on 2/24/24.
//

import SwiftUI
import FirebaseCore

// INIT FIREBASE SERVER TO GET IMAGES OF CARDS
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct RivalsApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var appState = AppState()
    @StateObject private var newDeckVM = NewDeckViewModel(appState: AppState())
    


    var body: some Scene {
        WindowGroup {
            if !appState.isAuthenticated {
                
                LoginView()
                    .environmentObject(appState)
                    
            } else {

                RivalTabView()
                    .environmentObject(appState)
                    .environmentObject(newDeckVM)
                    .modelContainer(for: [Card.self, DecksResponseData.self])
                   
            }
        }
    }
}

//
//  LoginPicView.swift
//  Rivals
//
//  Created by Cody hancock on 8/3/24.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var appState: AppState
    
    @State private var username = ""
    @State private var password = ""
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Image("vtm-bg")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .offset(x: 110)
                
                VStack(spacing: 20) {
                        
                    Text("VTM: Rivals")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.primary)
                        .offset(x: -70, y: -100)
                    
                    TextField("Username", text: self.$username)
                        .foregroundColor(.primary)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .textFieldStyle(.roundedBorder)
                        .placeholder(when: username.isEmpty) {
                            Text("Username")
                                .foregroundColor(.primary)
                                .bold()
                        }
                    
                    Rectangle()
                        .frame(width: 350, height: 1)
                        .foregroundColor(.white)
                    
                    SecureField("Password", text: self.$password)
                        .foregroundColor(.primary)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .textFieldStyle(.roundedBorder)
                        .placeholder(when: password.isEmpty) {
                            Text("Password")
                                .foregroundColor(.primary)
                                .bold()
                        }
                        
                    
                    Rectangle()
                        .frame(width: 350, height: 1)
                        .foregroundColor(.white)
    
         
                    Button("Sign In") {
                        appState.login(username: username, password: password)
                    }
                    .foregroundStyle(.blue)
                    
                    Spacer()
                        .frame(height:0)
                    
                    HStack {
                        Text("Need an account?")
                            .font(.headline)
                            .foregroundStyle(.gray)
                        
                        NavigationLink("Click here", destination: RegisterView())
                            .foregroundStyle(.red)
                    }
                }
                .frame(width: 350)
            }
            .ignoresSafeArea()
        }
        

    }
}

#Preview {
    LoginView()
        .environmentObject(AppState())
}



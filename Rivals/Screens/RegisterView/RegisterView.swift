//
//  RegisterView.swift
//  Rivals
//
//  Created by Cody hancock on 8/3/24.
//

import SwiftUI

struct RegisterView: View {
    
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) var dismiss
    
    @State private var email = ""
    @State private var username = ""
    @State private var password = ""
    @State private var confirmPass = ""
    @State private var isLoading = false
    @State private var showLogin = false
    
    
    var body: some View {
        
        
        ZStack {
            Image("swan")
            
            Rectangle()
                .frame(width: 550, height: 400)
                .foregroundStyle(.black.opacity(0.5))
                .blur(radius: 10.0)
                .cornerRadius(20)
            
            VStack(spacing: 15) {
                Spacer()
                    .frame(height: 40)
                Text("Register New Account")
                    .foregroundStyle(.white)
                    .font(.title)
                    .offset(x: -40, y: -80)
                
                Text("Email")
                    .font(.title3)
                    .foregroundStyle(.white)
                    .offset(x: -150)
                TextField("Email", text: $email)
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                
                Text("Username")
                    .font(.title3)
                    .foregroundStyle(.white)
                    .offset(x: -130)
                TextField("Username", text: $username)
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                
                Text("Password")
                    .font(.title3)
                    .foregroundStyle(.white)
                    .offset(x: -130)
                SecureField("Password", text: $password)
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                
                Text("Confirm Password")
                    .font(.title3)
                    .foregroundStyle(.white)
                    .offset(x: -95)
                SecureField("Confirm Password", text: $confirmPass)
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                
                Spacer()
                    .frame(height: 40)
                
                Button("Register Account") {
                    isLoading = true
                    appState.register(email: email, username: username, password: password, confirmPassword: confirmPass)
                    dismiss()
                }
                .foregroundStyle(.blue)
                .disabled(isLoading)
                
                if isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                }
            }
            .frame(width: 350)
        }
    }
}

#Preview {
    RegisterView()
}

//
//  LoginView.swift
//  Rivals
//
//  Created by Cody hancock on 2/24/24.
//


import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel = AccountViewModel()
    
    @State private var email = ""
    @State private var password = ""
    
    
    var body: some View {
        ZStack {
            Color.black

            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundColor(.bloodRed)
                .frame(width: 1000, height: 450)
                .rotationEffect(.degrees(135))
                .offset(x: -20, y: -300)
            
//            Image("mainBG")
//                .resizable()
//                .aspectRatio(contentMode: .fit)
            
            VStack(spacing: 20) {
                    
                Text("VTM: Rivals")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .offset(x: -70, y: -100)
                
                TextField("Email", text: $email)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: email.isEmpty) {
                        Text("Email")
                            .foregroundColor(.white)
                            .bold()
                    }
                
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.white)
                
                TextField("Password", text: $password)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: password.isEmpty) {
                        Text("Password")
                            .foregroundColor(.white)
                            .bold()
                    }
                
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.white)
                
                Spacer()
                    .frame(height: 80)
                
                Button {
                    //signup
                } label: {
                    NewDeckButton(buttonText: "Sign Up")
                }
                
                Text("Already have an account?")
                    .foregroundColor(.white)
                    .font(.title2)
                
                
            }
            .frame(width: 350)
        }
        .ignoresSafeArea()
    }
}


#Preview {
    LoginView()
}


// EXTENDS VIEW TO BE CAPABLE OF HAVING A PLACEHOLDER IN THE TEXTFIELD WHEN ITS EMPTY
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
        }
    }
}




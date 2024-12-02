//
//  LoginView.swift
//  AssignmentTracker
//
//  Created by Bálint Király on 2024. 12. 02..
//

import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    @State private var showPassword = false
    @State private var showSignUp = false
    
    var body: some View {
        VStack {
            Spacer()
            
            // App Title
            Text("Assignment Tracker")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.purple)
                .padding(.bottom, 20)
            
            // Email Field
            TextField("Email", text: $email)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 20)
            
            // Password Field
            HStack {
                if showPassword {
                    TextField("Password", text: $password)
                } else {
                    SecureField("Password", text: $password)
                }
                Button(action: {
                    showPassword.toggle()
                }) {
                    Image(systemName: showPassword ? "eye.slash" : "eye")
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding(.horizontal, 20)
            
            // Login Button
            Button(action: {
                // Handle login action
            }) {
                Text("Log In")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.purple)
                    .cornerRadius(8)
                    .padding(.horizontal, 20)
            }
            .padding(.top, 20)
            
            // Sign Up Navigation
            HStack {
                Text("New around here?")
                    .foregroundColor(.gray)
                Button(action: {
                    showSignUp.toggle()
                }) {
                    Text("Sign Up")
                        .fontWeight(.bold)
                        .foregroundColor(.purple)
                }
            }
            .padding(.top, 20)
            
            Spacer()
            
            // Footer
            Text("Made with ❤️ by Balint Kiraly")
                .font(.footnote)
                .foregroundColor(.gray)
                .padding(.bottom, 0)
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $showSignUp) {
            //SignUpView()
        }
    }
}

#Preview {
    LoginView()
}

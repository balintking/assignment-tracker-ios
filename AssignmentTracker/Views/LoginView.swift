//
//  LoginView.swift
//  AssignmentTracker
//
//  Created by Bálint Király on 2024. 12. 02..
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    @State private var showPassword = false
    @State private var showSignUp = false
    
    var body: some View {
        VStack {
            Spacer()
            
            // App Title
            Text("Assignment Tracker")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.purple)
                .padding(.bottom, 20)
            
            // Email Field
            TextField("Email", text: $viewModel.email)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 20)
            
            // Password Field
            HStack {
                if showPassword {
                    TextField("Password", text: $viewModel.password)
                } else {
                    SecureField("Password", text: $viewModel.password)
                }
                Button(action: {
                    showPassword.toggle()
                }) {
                    Image(systemName: showPassword ? "eye.slash" : "eye")
                        .foregroundStyle(.gray)
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding(.horizontal, 20)
            
            // Error Message
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundStyle(.red)
                    .font(.subheadline)
                    .padding(.top, 10)
            }
            
            // Login Button
            Button(action: {
                viewModel.login()
            }) {
                Text("Log In")
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
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
                    .foregroundStyle(.gray)
                Button(action: {
                    showSignUp.toggle()
                }) {
                    Text("Sign Up")
                        .fontWeight(.bold)
                        .foregroundStyle(.purple)
                }
            }
            .padding(.top, 20)
            
            Spacer()
            
            // Footer
            Text("Made with ❤️ by Balint Kiraly")
                .font(.footnote)
                .foregroundStyle(.gray)
                .padding(.bottom, 0)
        }
        .navigationBarHidden(true)
        .onTapGesture {
            hideKeyboard()
        }
        .sheet(isPresented: $showSignUp) {
            SignUpView()
        }
    }
}

#Preview {
    LoginView()
}

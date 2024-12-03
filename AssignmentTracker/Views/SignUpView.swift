//
//  SignUpView.swift
//  AssignmentTracker
//
//  Created by Bálint Király on 2024. 12. 02..
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = SignUpViewModel()
    @State private var showPassword = false
    
    var body: some View {
        VStack {
            Spacer()
            
            // Title
            Text("Create Account")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.purple)
                .padding(.bottom, 20)
            
            // Name Field
            TextField("Full Name", text: $viewModel.name)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 20)
            
            // Email Field
            TextField("Email", text: $viewModel.email)
                .autocapitalization(.none)
                .autocorrectionDisabled()
                .keyboardType(.emailAddress)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 20)
            
            // Password Field
            HStack {
                if showPassword {
                    TextField("Password", text: $viewModel.password)
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                } else {
                    SecureField("Password", text: $viewModel.password)
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
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
            
            // Confirm Password Field
            SecureField("Confirm Password", text: $viewModel.confirmPassword)
                .autocapitalization(.none)
                .autocorrectionDisabled()
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 20)
            
            // Error Message
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundStyle(.red)
                    .font(.subheadline)
                    .padding(.top, 5)
            }
            
            // Sign Up Button
            Button(action: {
                if !viewModel.isLoading {
                    viewModel.signUp()
                }                
            }) {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.purple)
                        .cornerRadius(8)
                        .padding(.horizontal, 20)
                } else {
                    Text("Sign Up")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.purple)
                        .cornerRadius(8)
                        .padding(.horizontal, 20)
                }
            }
            .disabled(viewModel.isLoading)
            .padding(.top, (viewModel.errorMessage == nil) ? 20 : 10)
            
            // Close Button
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Cancel")
                    .fontWeight(.bold)
                    .foregroundStyle(.purple)
                    .padding()
            }
            
            Spacer()
        }
        .navigationBarHidden(true)
        .onTapGesture {
            hideKeyboard()
        }
        .alert(isPresented: $viewModel.isSignUpSuccessful) {
            Alert(title: Text("Sign Up Successful"), message: Text("Your account has been created!"), dismissButton: .default(Text("OK"), action: {
                presentationMode.wrappedValue.dismiss()
            }))
        }
    }
}

#Preview {
    SignUpView()
}

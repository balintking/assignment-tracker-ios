//
//  ProfileView.swift
//  AssignmentTracker
//
//  Created by Bálint Király on 2024. 12. 03..
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @State private var showSignOutAlert: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                } else if let user = viewModel.user {
                    // Profile Details
                    VStack(spacing: 16) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.purple)
                            .padding(.top, 40)
                        
                        Text(user.name)
                            .font(.title)
                            .bold()
                        
                        Text(user.email)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        Text("Joined: \(viewModel.formatDate(from: user.joined))")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                } else if let errorMessage = viewModel.errorMessage {
                    // Error Message
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                
                // Sign Out Button
                Button(action: {
                    showSignOutAlert = true
                }) {
                    Text("Sign Out")
                        .font(.body)
                        .foregroundColor(.red)
                        .padding(.vertical, 10)
                }
                .padding(.horizontal, 30)
                .alert(isPresented: $showSignOutAlert) {
                    Alert(
                        title: Text("Sign Out"),
                        message: Text("Are you sure you want to sign out?"),
                        primaryButton: .destructive(Text("Sign Out")) {
                            viewModel.signOut()
                        },
                        secondaryButton: .cancel()
                    )
                }
                
                Spacer()
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.loadUserData()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    ProfileView()
}

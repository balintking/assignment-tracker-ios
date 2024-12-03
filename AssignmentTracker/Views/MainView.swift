//
//  ContentView.swift
//  AssignmentTracker
//
//  Created by Bálint Király on 2024. 12. 02..
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isUserSignedIn {
                    // Authenticated Content
                    VStack {
                        Text("Welcome to Assignment Tracker!")
                            .font(.title)
                            .padding()
                        Text("You are signed in.")
                            .font(.subheadline)
                        Button(action: {
                            viewModel.signOut()
                        }) {
                            Text("Sign Out")
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red)
                                .cornerRadius(8)
                                .padding(.horizontal, 20)
                        }
                    }
                } else {
                    LoginView()
                }
            }
            .onAppear {
                viewModel.checkAuthState()
            }
        }
    }
}

#Preview {
    MainView()
}

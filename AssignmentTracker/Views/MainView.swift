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
        Group {
            if viewModel.isUserSignedIn {
                mainContent
            } else {
                LoginView()
            }
        }
        .onAppear {
            viewModel.checkAuthState()
        }
    }
    
    @ViewBuilder
    var mainContent: some View {
        TabView {
            AssignmentsView()
                .tabItem {
                    Label("Assignments", systemImage: "list.bullet")
                }
            /*
            CoursesView()
                .tabItem {
                    Label("Courses", systemImage: "book.closed")
                }
             */
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
        }
        .accentColor(.purple)
    }
}

#Preview {
    MainView()
}

//
//  MainViewModel.swift
//  AssignmentTracker
//
//  Created by Bálint Király on 2024. 12. 03..
//

import Foundation
import FirebaseAuth

class MainViewModel: ObservableObject {
    @Published var isUserSignedIn: Bool = false
    @Published var currentUserId: String = ""
    
    init() {
        checkAuthState()
        
        // Listen for login/logout notifications
        NotificationCenter.default.addObserver(self, selector: #selector(authStateChanged), name: .authStateChanged, object: nil)
    }
    
    func checkAuthState() {
        isUserSignedIn = Auth.auth().currentUser != nil
        currentUserId = Auth.auth().currentUser?.uid ?? ""
    }
    
    @objc private func authStateChanged() {
        checkAuthState()
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            isUserSignedIn = false
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

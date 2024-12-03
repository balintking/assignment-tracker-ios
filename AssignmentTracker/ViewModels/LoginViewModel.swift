//
//  LoginViewModel.swift
//  AssignmentTracker
//
//  Created by Bálint Király on 2024. 12. 02..
//

import Foundation
import FirebaseAuth

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    

    
    func login() {
        errorMessage = nil
        
        guard validate() else {
            return
        }
        
        isLoading = true
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                } else {
                    NotificationCenter.default.post(name: .authStateChanged, object: nil)
                }
            }
        }
    }
    
    private func validate() -> Bool {
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            
            errorMessage = "All fields must be filled."
            return false
        }
        
        // Validate email
        guard isValidEmail(email) else {
            errorMessage = "Invalid email format."
            return false
        }
        
        return true
    }
}

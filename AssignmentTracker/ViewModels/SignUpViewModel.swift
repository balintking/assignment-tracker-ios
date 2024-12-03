//
//  SignUpViewModel.swift
//  AssignmentTracker
//
//  Created by Bálint Király on 2024. 12. 03..
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class SignUpViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    @Published var isSignUpSuccessful: Bool = false
    
    func signUp() {
        errorMessage = nil
        isSignUpSuccessful = false
        
        guard validate() else {
            return
        }
        
        isLoading = true
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let userId = result?.user.uid else {
                DispatchQueue.main.async {
                    self?.isLoading = false
                    self?.errorMessage = error?.localizedDescription
                }
                return
            }
            
            self?.insertUserRecord(id: userId)
            
            DispatchQueue.main.async {
                self?.isLoading = false
                self?.isSignUpSuccessful = true
            }
        }
    }
    
    private func validate()  -> Bool {
        // Check if all fields are filled
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              !confirmPassword.trimmingCharacters(in: .whitespaces).isEmpty else {
            
            errorMessage = "All fields must be filled."
            return false
        }
        
        // Validate email
        guard isValidEmail(email) else {
            errorMessage = "Invalid email format."
            return false
        }
        
        // Validate password length
        guard password.count >= 8  else {
            errorMessage = "Password must be at least 8 characters long."
            return false
        }
        
        // Validate confirm password
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match."
            return false
        }
        
        return true
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    private func insertUserRecord(id: String) {
        let newUser = User(id: id, name: name, email: email, joined: Date().timeIntervalSince1970)
        
        let db = Firestore.firestore()
        
        db.collection("users").document(id).setData(newUser.asDictionary())
    }
}

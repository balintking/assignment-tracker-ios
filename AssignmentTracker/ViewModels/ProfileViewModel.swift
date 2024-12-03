//
//  ProfileView.swift
//  AssignmentTracker
//
//  Created by Bálint Király on 2024. 12. 03..
//


import Foundation
import FirebaseAuth
import FirebaseFirestore

class ProfileViewModel: ObservableObject {
    @Published var user: User?
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    func loadUserData() {
        self.isLoading = true
        
        guard let userId = Auth.auth().currentUser?.uid else {
            self.errorMessage = "User not logged in."
            self.isLoading = false
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users").document(userId).getDocument { [weak self] snapshot, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.errorMessage = "Error loading user: \(error.localizedDescription)"
                    self?.isLoading = false
                    return
                }
                
                guard let data = snapshot?.data() else {
                    self?.errorMessage = "User data not found."
                    self?.isLoading = false
                    return
                }
                
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data)
                    self?.user = try JSONDecoder().decode(User.self, from: jsonData)
                    self?.isLoading = false
                } catch {
                    self?.errorMessage = "Failed to parse user data: \(error.localizedDescription)"
                    self?.isLoading = false
                }
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            NotificationCenter.default.post(name: .authStateChanged, object: nil)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    func formatDate(from timeInterval: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timeInterval)
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

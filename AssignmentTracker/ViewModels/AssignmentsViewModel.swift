//
//  AssignmentsViewModel.swift
//  AssignmentTracker
//
//  Created by Bálint Király on 2024. 12. 03..
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


class AssignmentsViewModel: ObservableObject {
    @Published var assignments: [Assignment] = []
    @Published var isLoading: Bool = false
    
    func loadAssignments() {
        isLoading = true
        guard let userId = Auth.auth().currentUser?.uid else {
            isLoading = false
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users/\(userId)/assignments").getDocuments { [weak self] snapshot, error in
            if let error = error {
                self?.isLoading = false
                print("Error loading assignments: \(error)")
                return
            }
            
            self?.assignments = snapshot?.documents.compactMap { document in
                try? document.data(as: Assignment.self)
            } ?? []
            self?.isLoading = false
        }
    }
    
    // Group assignments by day
    var groupedAssignments: [Date: [Assignment]] {
        Dictionary(grouping: assignments) { assignment in
            Calendar.current.startOfDay(for: Date(timeIntervalSince1970: assignment.dueDate))
        }
    }
    
    // Generate section header titles
    func sectionHeader(for date: Date) -> String {
        if Calendar.current.isDateInToday(date) {
            return "Today"
        } else if Calendar.current.isDateInTomorrow(date) {
            return "Tomorrow"
        } else {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            return formatter.string(from: date)
        }
    }
}

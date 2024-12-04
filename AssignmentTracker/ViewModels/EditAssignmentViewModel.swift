//
//  AddEditAssignmentViewModel.swift
//  AssignmentTracker
//
//  Created by Bálint Király on 2024. 12. 03..
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import SwiftUICore

class EditAssignmentViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var dueDate: Date = Date()
    @Published var course: String = ""
    @Published var status: AssignmentStatus = .notStarted
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private var originalAssignment: Assignment? = nil
    
    private let db = Firestore.firestore()
    
    var validInput: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    func load(assignment: Assignment) {
        self.originalAssignment = assignment
        self.name = assignment.name
        self.course = assignment.course ?? ""
        self.status = assignment.status
        self.dueDate = Date(timeIntervalSince1970: assignment.dueDate)
    }
    
    func cancelChanges() {
        if originalAssignment != nil {
            self.name = originalAssignment!.name
            self.dueDate = Date(timeIntervalSince1970: originalAssignment!.dueDate)
            self.course = originalAssignment!.course ?? ""
            self.status = originalAssignment!.status
        } else {
            self.name = ""
            self.dueDate = Date()
            self.course = ""
            self.status = .notStarted
        }
    }
    
    func saveAssignment(assignmentId: String? = nil, completion: @escaping (Bool) -> Void) {
        errorMessage = nil
        
        guard validInput else {
            errorMessage = "Name field must be filled."
            return
        }
        
        guard let userId = Auth.auth().currentUser?.uid else {
            errorMessage = "Failed to retrieve user ID."
            NotificationCenter.default.post(name: .AuthStateDidChange, object: nil)
            return
        }
        
        isLoading = true
        
        if let assignmentId = assignmentId {
            // Update existing assignment
            let updatedAssignment = Assignment(id: assignmentId, name: name, dueDate: dueDate.timeIntervalSince1970, course: course, status: status)
            
            db.collection("users").document(userId).collection("assignments").document(assignmentId).updateData(updatedAssignment.asDictionary()) { error in
                DispatchQueue.main.async {
                    self.isLoading = false
                    if let error = error {
                        self.errorMessage = "Failed to update assignment: \(error.localizedDescription)"
                        completion(false)
                    } else {
                        completion(true)
                    }
                }
            }
        } else {
            // Create new assignment
            let newId = UUID().uuidString
            let newAssignment = Assignment(id: newId, name: name, dueDate: dueDate.timeIntervalSince1970, course: course, status: status)
            
            db.collection("users").document(userId).collection("assignments").document(newId).setData(newAssignment.asDictionary()) { error in
                DispatchQueue.main.async {
                    self.isLoading = false
                    if let error = error {
                        self.errorMessage = "Failed to save assignment: \(error.localizedDescription)"
                        completion(false)
                    } else {
                        completion(true)
                    }
                }
            }
        }
    }
}

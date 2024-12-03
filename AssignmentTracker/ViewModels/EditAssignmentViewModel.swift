//
//  AddEditAssignmentViewModel.swift
//  AssignmentTracker
//
//  Created by Bálint Király on 2024. 12. 03..
//

import Foundation

class EditAssignmentViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var dueDate: Date = Date()
    @Published var course: String = ""
    @Published var status: AssignmentStatus = .notStarted
}

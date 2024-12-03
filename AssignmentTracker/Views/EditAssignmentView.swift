//
//  AddEditAssignmentView.swift
//  AssignmentTracker
//
//  Created by Bálint Király on 2024. 12. 03..
//


import SwiftUI

struct EditAssignmentView: View {
    @Environment(\.dismiss) private var dismiss
    //@Binding var assignment: Assignment?

    @StateObject var viewModel = EditAssignmentViewModel()

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $viewModel.name)
                DatePicker("Due Date", selection: $viewModel.dueDate, displayedComponents: .date)
                TextField("Course", text: $viewModel.course)
                Picker("Status", selection: $viewModel.status) {
                    ForEach(AssignmentStatus.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
            }
            .navigationTitle(/*assignment == nil ? "Add Assignment" : */"Edit Assignment")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
        .onAppear {
            
        }
    }
}

#Preview {
    EditAssignmentView()
}

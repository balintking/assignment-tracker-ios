//
//  AddEditAssignmentView.swift
//  AssignmentTracker
//
//  Created by Bálint Király on 2024. 12. 03..
//


import SwiftUI

struct EditAssignmentView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel = EditAssignmentViewModel()
    @State var shakeDetector: ShakeDetector? = nil
    
    var onDissapear: () -> Void
    
    private var feedbackGenerator: UIImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
    
    var assignment: Assignment?
    
    init(assignment: Assignment? = nil, onDissapear: @escaping () -> Void) {
        self.assignment = assignment
        self.onDissapear = onDissapear
    }
    
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
                
                // Error Message
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                        .font(.subheadline)
                        .padding(.top, 5)
                }
            }
            .navigationTitle(assignment == nil ? "Add Assignment" : "Edit Assignment")
            .onAppear {
                if let assignment = assignment {
                    viewModel.load(assignment: assignment)
                }
                shakeDetector = ShakeDetector(onShake: {
                    self.triggerVibration()
                    viewModel.cancelChanges()
                })
                shakeDetector?.startShakeDetection()
            }
            .onDisappear {
                shakeDetector?.stopShakeDetection()
                onDissapear()
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        viewModel.saveAssignment(assignmentId: assignment?.id) { success in
                            if success {
                                dismiss()
                            }
                        }
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func triggerVibration() {
        feedbackGenerator.prepare()
        feedbackGenerator.impactOccurred()
    }
}

#Preview {
    EditAssignmentView(assignment: nil, onDissapear: {})
}

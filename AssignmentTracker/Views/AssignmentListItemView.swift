//
//  AssignmentListItemView.swift
//  AssignmentTracker
//
//  Created by Bálint Király on 2024. 12. 03..
//


import SwiftUI

struct AssignmentListItemView: View {
    var assignment: Assignment
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                // Assignment Name
                Text(assignment.name)
                    .font(.headline)
                
                // Course Name
                Text(assignment.course ?? "")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
            
            Spacer()
            
            // Status Label
            Text(assignment.status.rawValue)
                .font(.caption)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(assignment.status.color)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
    }
}

#Preview {
    AssignmentListItemView(assignment: Assignment(id: "1234", name: "Math Homework", dueDate: Date().timeIntervalSince1970, course: "Mathematics", status: .inProgress))
}

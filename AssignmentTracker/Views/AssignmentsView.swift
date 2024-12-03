//
//  AssignmentsView.swift
//  AssignmentTracker
//
//  Created by Bálint Király on 2024. 12. 03..
//

import SwiftUI

struct AssignmentsView: View {
    @StateObject var viewModel = AssignmentsViewModel()
    @State private var showAddAssignment = false
    
    var body: some View {
        NavigationView {
            VStack {/*
                ForEach(assignments) { assignment in
                    NavigationLink(destination: AssignmentDetailView(assignment: assignment)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(assignment.title)
                                    .font(.headline)
                                Text(assignment.course)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Text(assignment.status.rawValue)
                                .font(.caption)
                                .foregroundColor(assignment.status.color)
                        }
                        .padding(.vertical, 8)
                                    }
                                    }
                                    .onDelete(perform: deleteAssignment)*/
            }
            .navigationTitle("Assignments")
            .toolbar {
                Button(action: {
                    showAddAssignment = true
                }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showAddAssignment) {
                EditAssignmentView()
            }
        }
        
    }
}

#Preview {
    AssignmentsView()
}

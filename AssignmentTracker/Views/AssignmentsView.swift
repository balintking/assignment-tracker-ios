//
//  AssignmentsView.swift
//  AssignmentTracker
//
//  Created by Bálint Király on 2024. 12. 03..
//

import SwiftUI
import FirebaseFirestore

struct AssignmentsView: View {
    @StateObject var viewModel = AssignmentsViewModel()
    @FirestoreQuery var assignments: [Assignment]
    @State private var showAddAssignment = false
    
    init(userId: String) {
        self._assignments = FirestoreQuery(collectionPath: "users/\(userId)/assignments")
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading, pinnedViews: [.sectionHeaders]) {
                    ForEach(groupedAssignments.keys.sorted(), id: \.self) { key in
                        Section(header: SectionHeaderView(title: sectionHeader(for: key))) {
                            ForEach(groupedAssignments[key]!, id: \.id) { assignment in
                                NavigationLink(destination: EditAssignmentView(assignment: assignment)) {
                                    AssignmentListItemView(assignment: assignment)
                                        .padding(.horizontal)
                                }
                            }
                        }
                    }
                }
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
    
    // Group assignments by day
    private var groupedAssignments: [Date : [Assignment]] {
        Dictionary(grouping: assignments) { assignment in
            Calendar.current.startOfDay(for: Date(timeIntervalSince1970: assignment.dueDate))
        }
    }
    
    // Generate section headers
    private func sectionHeader(for date: Date) -> String {
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

struct SectionHeaderView: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(UIColor.systemGroupedBackground))
    }
}

#Preview {
    AssignmentsView(userId: "3oD8asMG4DSZsDKzQxtMrNHgVCu2")
}

//
//  AssignmentsView.swift
//  AssignmentTracker
//
//  Created by Bálint Király on 2024. 12. 03..
//

import SwiftUI

struct AssignmentsView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @StateObject var viewModel = AssignmentsViewModel()
    @State private var showEditAssignment = false
    @State private var selectedAssignment: Assignment?
    
    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.isLoading {
                    ProgressView("Loading Assignments...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .foregroundColor(.gray)
                } else if viewModel.assignments.isEmpty {
                    Text("You're all set")
                        .font(.title3)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding()
                } else {
                    ScrollView {
                        LazyVStack(alignment: .leading, pinnedViews: [.sectionHeaders]) {
                            assignmentsList
                        }
                    }
                }
            }
            .frame(maxWidth: horizontalSizeClass == .compact ? .infinity:  700)
            .padding(.top, horizontalSizeClass == .compact ? 0 : 40)
            .navigationTitle("Assignments")
            .toolbar {
                Button(action: {
                    selectedAssignment = nil
                    showEditAssignment = true
                }) {
                    Image(systemName: "plus")
                }
            }
            .onAppear(perform: viewModel.loadAssignments)
            .refreshable {
                viewModel.loadAssignments()
            }
            .sheet(isPresented: $showEditAssignment) {
                EditAssignmentView(assignment: selectedAssignment, onDissapear: viewModel.loadAssignments)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    var assignmentsList: some View {
        ForEach(viewModel.groupedAssignments.keys.sorted(), id: \.self) { key in
            Section(header: SectionHeaderView(title: viewModel.sectionHeader(for: key))) {
                ForEach(viewModel.groupedAssignments[key]!, id: \.id) { assignment in
                    Button(action: {
                        selectedAssignment = assignment
                        showEditAssignment = true
                    }) {
                        AssignmentListItemView(assignment: assignment)
                            .padding(.horizontal)
                    }
                    .contextMenu {
                        Button(action: {
                            viewModel.deleteAssignment(id: assignment.id)
                        }) {
                            Label("Delete", systemImage: "trash")
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
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

struct AssignmentRow: View {
    let assignment : Assignment
    let onDissapear: () -> Void
    
    var body: some View {
        NavigationLink(destination: EditAssignmentView(assignment: assignment, onDissapear: onDissapear)) {
            AssignmentListItemView(assignment: assignment)
                .padding(.horizontal)
        }
    }
}

#Preview {
    AssignmentsView()
}

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
            ZStack {
                if viewModel.isLoading {
                    ProgressView("Loading Assignments...") // Display a loading indicator
                        .progressViewStyle(CircularProgressViewStyle())
                        .foregroundColor(.gray)
                } else if viewModel.assignments.isEmpty {
                    Text("No Assignments Found")
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
            .navigationTitle("Assignments")
            .toolbar {
                Button(action: {
                    showAddAssignment = true
                }) {
                    Image(systemName: "plus")
                }
            }
            .onAppear(perform: viewModel.loadAssignments)
            .sheet(isPresented: $showAddAssignment) {
                EditAssignmentView()
            }
            .refreshable {
                viewModel.loadAssignments()
            }
        }
    }
    
    var assignmentsList: some View {
        ForEach(viewModel.groupedAssignments.keys.sorted(), id: \.self) { key in
            Section(header: SectionHeaderView(title: viewModel.sectionHeader(for: key))) {
                ForEach(viewModel.groupedAssignments[key]!, id: \.id) { assignment in
                    NavigationLink(destination: EditAssignmentView(assignment: assignment)) {
                        AssignmentListItemView(assignment: assignment)
                            .padding(.horizontal)
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

#Preview {
    AssignmentsView()
}

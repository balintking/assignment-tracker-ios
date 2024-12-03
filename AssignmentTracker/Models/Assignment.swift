//
//  Assignment.swift
//  AssignmentTracker
//
//  Created by Bálint Király on 2024. 12. 03..
//

import Foundation
import SwiftUICore

struct Assignment: Codable, Identifiable {
    let id: String
    var name: String
    var dueDate: TimeInterval
    var course: String?
    var status: AssignmentStatus
}

enum AssignmentStatus: String, Codable, CaseIterable {
    case notStarted = "Not Started"
    case inProgress = "In Progress"
    case done = "Done"
    case failed = "Failed"

    var color: Color {
        switch self {
        case .notStarted: return .gray
        case .inProgress: return .blue
        case .done: return .green
        case .failed: return .red
        }
    }
}

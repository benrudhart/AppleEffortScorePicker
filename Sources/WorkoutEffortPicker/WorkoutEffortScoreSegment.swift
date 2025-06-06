// Copyright (c) 2025 Ben Rudhart

import SwiftUI

enum WorkoutEffortScoreSegment: String, CaseIterable {
    case easy
    case moderate
    case hard
    case allOut
}

extension WorkoutEffortScoreSegment: Identifiable {
    var id: String {
        rawValue
    }
}

extension WorkoutEffortScoreSegment {
    @available(iOS 18.0, watchOS 11.0, *)
    var scores: ClosedRange<WorkoutEffortScore> {
        switch self {
        case .easy: .easy1 ... .easy3
        case .moderate: .moderate1 ... .moderate3
        case .hard: .hard1 ... .hard2
        case .allOut: .allOut1 ... .allOut2
        }
    }

    var localizedTitle: LocalizedStringKey {
        switch self {
        case .easy: "scoreSegment.easy.title"
        case .moderate: "scoreSegment.moderate.title"
        case .hard: "scoreSegment.hard.title"
        case .allOut: "scoreSegment.allOut.title"
        }
    }

    var localizedDescription: LocalizedStringKey {
        switch self {
        case .easy: "scoreSegment.easy.description"
        case .moderate: "scoreSegment.moderate.description"
        case .hard: "scoreSegment.hard.description"
        case .allOut: "scoreSegment.allOut.description"
        }
    }
}

// Copyright (c) 2025 Ben Rudhart

import UIKit
import HealthKit

@available(iOS 18.0, watchOS 11.0, *)
@Observable @MainActor
final class WorkoutEffortButtonViewModel: WorkoutEffortButtonViewModelProtocol {
    let workout: HKWorkout
    private let healthStore: HKHealthStore
    private var didFetchScore = false
    private(set) var score: WorkoutEffortScore?
    private(set) var isPermissionDenied: Bool

    init(workout: HKWorkout) {
        self.workout = workout
        self.healthStore = HKHealthStore()
        self.isPermissionDenied = healthStore.authorizationStatus(for: .effortType) == .sharingDenied
    }

    func onForeground() {
        isPermissionDenied = healthStore.authorizationStatus(for: .effortType) == .sharingDenied
    }

    func saveScore(_ score: WorkoutEffortScore?) {
        Task {
            do {
                try await healthStore.setEffortScore(score, workout: workout)
                self.score = score
            } catch {
                assertionFailure(error.localizedDescription)
            }
        }
    }

    func onAppear() {
        guard !didFetchScore else { return }

        didFetchScore = true
        Task {
            do {
                score = try await healthStore.fetchEffortScore(workout: workout)
            } catch {
                assertionFailure(error.localizedDescription)
                didFetchScore = false
            }
        }
    }
}

import Foundation
import os
import SwiftData

@MainActor
@Observable
final class OnboardingStore: Logging {
    // MARK: - Properties

    var currentPage = 0
    var name: String = ""
    var hrMax: Int = 220
    var hrResting: Int = 70
    var ftp: Int = 0
    var weight: Double = 0.0
    var height: Double = 0.0
    var birthDate: Date = .init()

    private var modelContext: ModelContext?

    var isNameValid: Bool {
        guard !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return false
        }
        return true
    }

    // MARK: - Initializer

    init() {
        Logger.app.info("[\(self.typeName)] initialized, context passed")
    }

    // MARK: - Functions

    func loadContext(modelContext: ModelContext) {
        self.modelContext = modelContext
        Logger.database.info("[\(self.typeName)] received Context. Context Loaded.")
    }

    func completeOnboarding() {
        guard isNameValid else {
            Logger.database.error("[\(self.typeName)] cannot insert athlete, missing data")
            return
        }
        let athlete = Athlete(
            name: name,
            hrMax: hrMax,
            ftp: ftp,
            weight: weight,
            height: height,
            birthDate: birthDate
        )

        guard let context = modelContext else {
            Logger.database.error("[\(self.typeName)] cannot insert athlete, no context")
            return
        }

        context.insert(athlete)
    }
}

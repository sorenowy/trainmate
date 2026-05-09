import Foundation
import HealthKit
import os
import SwiftUI

@Observable
@MainActor
final class AthleteDataFormOnboardingViewModel: Logging {
    private let readDatabaseClient: any DatabaseClientProtocol
    private let writeDatabaseClient: any BackgroundDatabaseClientProtocol
    private let healthKitClient: any HealthKitClientProtocol

    var athlete: Athlete = .init()
    var isHealthKitSynced: Bool = false
    var isLoading: Bool = false
    var isError: Bool = false
    var error: Error?

    var isReady: Bool {
        !athlete.name.isEmpty && isHealthKitSynced && !isLoading
    }

    init(
        readDatabaseClient: any DatabaseClientProtocol,
        writeDatabaseClient: any BackgroundDatabaseClientProtocol,
        healthKitClient: any HealthKitClientProtocol
    ) {
        self.readDatabaseClient = readDatabaseClient
        self.writeDatabaseClient = writeDatabaseClient
        self.healthKitClient = healthKitClient
        Logger.app.info("[\(self.typeName)] initialized")
    }

    func syncWithHealthKit() async throws {
        isLoading = true
        Logger.app.info("[\(self.typeName)] synchronizing with HealthKit")
        defer { withAnimation { isLoading = false } }

        do {
            let biometrics = try await callHealthKitClient()
            guard let biometrics else {
                Logger.app.error("[\(self.typeName)] no biometric data fetched")
                return
            }
            Logger.network.info("[\(self.typeName)] fetched biometric data")

            if let weight = biometrics.weight {
                athlete.weight = weight
            }
            if let dateofBirth = biometrics.dateOfBirth {
                athlete.birthDate = dateofBirth
            }
            if let height = biometrics.height {
                athlete.height = height
            }
            athlete.biologicalSex = biometrics.biologicalSex

            withAnimation { [weak self] in
                self?.isHealthKitSynced = true
            }
        } catch {
            self.isError = true
            self.error = error
            Logger.app.error("[\(self.typeName)] failed to fetch biometric data: \(error.localizedDescription)]")
        }
    }

    @concurrent private func callHealthKitClient() async throws
        -> HealthKitData?
    {
        let authorized = try await healthKitClient.requestAuthorization()

        if authorized {
            return try await healthKitClient.fetchBiometrics()
        }
        return nil
    }
}

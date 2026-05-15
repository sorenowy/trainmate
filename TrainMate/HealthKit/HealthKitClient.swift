//
//  HealthKitClient.swift
//  TrainMate
//
//  Created by Hubert Kuszyński on 09/05/2026.
//

import Foundation
import HealthKit

protocol HealthKitClientProtocol: Sendable {
    func requestAuthorization() async throws -> Bool
    func fetchBiometrics() async throws
        -> HealthKitData
}

final class HealthKitClient: HealthKitClientProtocol {
    private let healthStore = HKHealthStore()

    init() {}

    func requestAuthorization() async throws -> Bool {
        guard HKHealthStore.isHealthDataAvailable() else {
            throw NSError(
                domain: "TrainMate",
                code: 1,
                userInfo: [NSLocalizedDescriptionKey: "HealthKit is not available on this device."]
            )
        }

        let typesToLoad: Set<HKObjectType> = [
            HKObjectType.quantityType(forIdentifier: .bodyMass)!,
            HKObjectType.quantityType(forIdentifier: .height)!,
            HKObjectType.characteristicType(forIdentifier: .biologicalSex)!,
            HKObjectType.characteristicType(forIdentifier: .dateOfBirth)!,
            HKObjectType.quantityType(forIdentifier: .vo2Max)!,
            HKObjectType.quantityType(forIdentifier: .cyclingFunctionalThresholdPower)!,
            HKObjectType.quantityType(forIdentifier: .heartRateVariabilitySDNN)!
        ]

        try await healthStore.requestAuthorization(toShare: [], read: typesToLoad)
        return true
    }

    func fetchBiometrics() async throws
        -> HealthKitData
    {
        let birthDate = try? healthStore.dateOfBirthComponents().date
        let biologicalSex = try? healthStore.biologicalSex().biologicalSex

        async let weightQuantity = fetchLatestQuantitySample(for: .bodyMass)
        async let heightQuantity = fetchLatestQuantitySample(for: .height)

        async let vo2MaxQuantity = fetchLatestQuantitySample(for: .vo2Max)
        async let ftpQuantity = fetchLatestQuantitySample(for: .cyclingFunctionalThresholdPower)
        async let hrvQuantity = fetchLatestQuantitySample(for: .heartRateVariabilitySDNN)

        let weight: Double? = try await weightQuantity?.doubleValue(for: .gramUnit(with: .kilo))
        let height: Double? = try await heightQuantity?.doubleValue(for: .meter())
        let vo2Max: Double? = try await vo2MaxQuantity?.doubleValue(for: .literUnit(with: .milli))
        let hrv: Double? = try await hrvQuantity?.doubleValue(for: HKUnit(from: "ms"))
        let ftp: Double? = try await ftpQuantity?.doubleValue(for: .watt())

        guard let healthKitSex = biologicalSex else {
            throw NSError(
                domain: "TrainMate",
                code: 1,
                userInfo: [NSLocalizedDescriptionKey: "Failed to retrieve biological sex"]
            )
        }

        return HealthKitData(
            biologicalSex: UserSex(rawValue: healthKitSex.rawValue) ?? .notSet,
            dateOfBirth: birthDate,
            height: height,
            weight: weight,
            ftp: ftp,
            vo2Max: vo2Max,
            hrv: hrv
        )
    }

    // MARK: - Private helpers

    private func fetchLatestQuantitySample(for identifier: HKQuantityTypeIdentifier) async throws -> HKQuantity? {
        guard let sampleType = HKObjectType.quantityType(forIdentifier: identifier) else {
            return nil
        }

        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)

        return try await withCheckedThrowingContinuation { continuation in
            let query = HKSampleQuery(
                sampleType: sampleType,
                predicate: nil,
                limit: 1,
                sortDescriptors: [sortDescriptor]
            ) { _, samples, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }

                // First element as fresh here
                guard let sample = samples?.first as? HKQuantitySample else {
                    continuation.resume(returning: nil)
                    return
                }

                continuation.resume(returning: sample.quantity)
            }

            self.healthStore.execute(query)
        }
    }
}

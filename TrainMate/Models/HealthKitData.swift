//
//  HealthKitData.swift
//  TrainMate
//
//  Created by Hubert Kuszyński on 09/05/2026.
//

import Foundation
import HealthKit

enum UserSex: Int, Sendable, Codable, CaseIterable {
    case notSet = 0
    case female = 1
    case male = 2
    case other = 3
}

struct HealthKitData: Sendable {
    var biologicalSex: UserSex
    var dateOfBirth: Date?
    var height: Double?
    var weight: Double?
}

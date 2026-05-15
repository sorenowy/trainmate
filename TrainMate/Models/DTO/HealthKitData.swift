import Foundation
import HealthKit

enum UserSex: Int, Codable, CaseIterable {
    case notSet = 0
    case female = 1
    case male = 2
    case other = 3
}

struct HealthKitData {
    var biologicalSex: UserSex
    var dateOfBirth: Date?
    var height: Double?
    var weight: Double?
    var ftp: Double?
    var vo2Max: Double?
    var hrv: Double?
}

extension UserSex {
    var localizedDescription: String.LocalizationValue {
        switch self {
        case .notSet:
            return "app.onboarding.user.sex.notSet"
        case .female:
            return "app.onboarding.user.sex.female"
        case .male:
            return "app.onboarding.user.sex.male"
        case .other:
            return "app.onboarding.user.sex.other"
        }
    }
}

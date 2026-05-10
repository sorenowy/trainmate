import Foundation
import HealthKit
import SwiftData

@Model
class Athlete {
    var name: String = ""
    var biologicalSex: UserSex = UserSex.female
    var hrMax: Int = 220
    var hrResting: Int = 70
    var ftp: Int = 0 // Functional Threshold Power (cycling)
    var runningThresholdPace: Double = 0.0 // min/km
    var weight: Double = 0.0 // kilograms
    var height: Double = 0.0 // centimeters
    var birthDate: Date = Date()

    init(
        name: String = "",
        hrMax: Int = 220,
        hrResting: Int = 70,
        ftp: Int = 0,
        runningThresholdPace: Double = 0.0,
        weight: Double = 0.0,
        height: Double = 0.0,
        birthDate: Date = Date()
    ) {
        self.name = name
        self.hrMax = hrMax
        self.hrResting = hrResting
        self.ftp = ftp
        self.runningThresholdPace = runningThresholdPace
        self.weight = weight
        self.height = height
        self.birthDate = birthDate
    }
}

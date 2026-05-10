import Foundation
import SwiftData

@Model
class Workout: Identifiable {
    var id: UUID = UUID()
    var name: String = ""
    var duration: TimeInterval = 0
    var isCompleted: Bool = false

    init(id: UUID = UUID(), name: String = "", duration: TimeInterval = 0, isCompleted: Bool = false) {
        self.id = id
        self.name = name
        self.duration = duration
        self.isCompleted = isCompleted
    }
}

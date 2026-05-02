import Foundation
import SwiftUI

enum AppSettings {
    @AppStorage("isNotificationsEnabled")
    static var isNotificationsEnabled: Bool = true

    @AppStorage("isMetricSystem")
    static var isMetricSystem: Bool = true
}

import Foundation
import SwiftData
import os

@Observable
final class SettingsStore: Logging {
    
    var isNotificationsEnabled: Bool = AppSettings.isNotificationsEnabled {
        didSet { AppSettings.isNotificationsEnabled = isNotificationsEnabled }
    }
    
    var isMetricSystem: Bool = AppSettings.isMetricSystem {
        didSet { AppSettings.isMetricSystem = isMetricSystem }
    }
    
    init() {
        Logger.app.info("[\(self.typeName)] Settings Store Initialized")
    }
}

import Foundation

protocol UserSettingsProtocol {
    func finishOnboarding()
}

final class UserSettings: UserSettingsProtocol {
    func finishOnboarding() {
        UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
    }
}

final class MockUserSettings: UserSettingsProtocol {
    var didCallFinishOnboarding: Bool = false
    
    func finishOnboarding() {
        didCallFinishOnboarding = true
    }
}

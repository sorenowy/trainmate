//
//  L10n.swift
//  TrainMate
//
//  Created by Hubert Kuszyński on 06/05/2026.
//

import Foundation

enum L10n {
    enum Dashboard {
        static func greeting(name: String) -> String {
            let formatString = String(localized: "app.dashboard.greeting")
            return String(format: formatString, name)
        }
    }

    enum Workout {}
    enum History {}
    enum Settings {}
    enum Onboarding {
        static let onboardingPageOneTitle = LocalizedStringResource("app.onboarding.title.one")
        static let onboardingPageTwoTitle = LocalizedStringResource("app.onboarding.title.two")
        static let onboardingPageThreeTitle = LocalizedStringResource("app.onboarding.title.three")

        static let onboardingPageOneDescription = LocalizedStringResource("app.onboarding.description.one")
        static let onboardingPageTwoDescription = LocalizedStringResource("app.onboarding.description.two")
        static let onboardingPageThreeDescription = LocalizedStringResource("app.onboarding.description.three")
    }

    static let appTitle = LocalizedStringResource("app.title")
}

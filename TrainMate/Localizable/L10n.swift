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
        
        static let onboardingAthletePageTitle = LocalizedStringResource("app.onboarding.athlete.title")
        static let onboardingAthletePagePersonalDataTitle = LocalizedStringResource("app.onboarding.athlete.personalData.title")
        static let onboardingAthletePageNameLabel = LocalizedStringResource("app.onboarding.athlete.name")
        static let onboardingAthleteWeightLabel = LocalizedStringResource("app.onboarding.athlete.weight.label")
        static let onboardingAthleteHeightLabel = LocalizedStringResource("app.onboarding.athlete.height.label")
        static let onboardingAthleteFooter = LocalizedStringResource("app.onboarding.athlete.footer")
        static let onboardingAthletePageHealthKitButton = LocalizedStringResource("app.onboarding.athlete.hk.button")
        static let onboardingAthleteFinishButton = LocalizedStringResource("app.onboarding.athlete.finish.button")
        static let onboardingAthleteDateLabel = LocalizedStringResource("app.onboarding.athlete.date")
        static let onboardingAthleteMetricsTitle = LocalizedStringResource("app.onboarding.athlete.metrics.title")
        static let onboardingAthleteSexLabel = LocalizedStringResource("app.onboarding.athlete.sex.title")
    }

    static let appTitle = LocalizedStringResource("app.title")
    
    // MARK: Buttons
    static let acknowledgeButtonTitle: LocalizedStringResource = "app.button.acknowledged"
}

import SnapshotTesting
import SwiftUI
import Testing
@testable import TrainMate

@Suite("[Snapshot] OnboardingView Snapshot Tests")
@MainActor
final class OnboardingViewSnapshotTests {
    
    let mockDIContainer = MockDIContainer()
    let appRouter = AppRouter()
    
    struct SnapshotConfig {
        let style: UIUserInterfaceStyle
        let locale: Locale
        let snapshotName: String
    }
    
    @Test(
        "Shows initial onboarding page",
        arguments: [
            SnapshotConfig(style: .light, locale: Locale(identifier: "pl_PL"), snapshotName: "LightMode_PL"),
            SnapshotConfig(style: .dark, locale: Locale(identifier: "en_US"), snapshotName: "DarkMode_US")
        ]
    )
    func onboardingPageRootView(config: SnapshotConfig) {
        let view = OnboardingView()
            .environment(\.diContainer, mockDIContainer)
            .environment(appRouter)
            .environment(\.locale, config.locale)
        
        let viewController = UIHostingController(rootView: view)
                
        assertSnapshot(of: viewController, as: .image(on: .iPhone13Pro, traits: .init(userInterfaceStyle: config.style)), named: config.snapshotName)
    }
}

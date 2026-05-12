import SnapshotTesting
import SwiftUI
import Testing
@testable import TrainMate

@Suite("OnboardingView Snapshot Tests")
@MainActor
final class OnboardingViewSnapshotTests {
    
    let mockDIContainer = MockDIContainer()
    let appRouter = AppRouter()
    
    @Test(
        "Shows initial onboarding page",
        arguments: [
            (UIUserInterfaceStyle.dark, "DarkMode"),
            (UIUserInterfaceStyle.light, "LightMode")
        ]
    )
    func onboardingPageRootView(style: UIUserInterfaceStyle, snapshotName: String) {
        let view = OnboardingView()
            .environment(\.diContainer, mockDIContainer)
            .environment(appRouter)
        
        let viewController = UIHostingController(rootView: view)
                
        assertSnapshot(of: viewController, as: .image(on: .iPhone13Pro, traits: .init(userInterfaceStyle: style)), named: snapshotName)
    }
}

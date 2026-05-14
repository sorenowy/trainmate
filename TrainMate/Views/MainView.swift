import SwiftData
import SwiftUI

struct MainView: View {
    @Environment(AppRouter.self) private var router: AppRouter
    @Environment(\.diContainer) private var dependencyContainer: any DIContainer

    private var sessionManager: SessionManager {
        dependencyContainer.sessionManager
    }

    var body: some View {
        Group {
            switch router.root {
            case .loading:
                ProgressView("Loading...")
                    .onAppear {
                        verifySessionAndRoute()
                    }
            case .onboarding:
                OnboardingView()
            case .mainApp:
                RootTabView()
                    .tint(.primaryColor)
            }
        }
        // TODO: If going with iPadOS/macOS, there we shift towards other UI
    }

    private func verifySessionAndRoute() {
        if dependencyContainer.sessionManager.state == .noAthlete {
            router.switchRoot(to: .onboarding)
        } else {
            router.switchRoot(to: .mainApp)
        }
    }
}

#Preview("Preview with athlete") {
    let container = MockDIContainer(hasAthlete: true)
    MainView()
        .environment(\.diContainer, container)
}

#Preview("Preview no athlete in system") {
    MainView()
        .environment(\.diContainer, MockDIContainer(hasAthlete: false))
}

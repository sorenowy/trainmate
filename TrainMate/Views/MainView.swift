import SwiftData
import SwiftUI

struct MainView: View {
    @Environment(\.diContainer) private var dependencyContainer: any DIContainer

    private var sessionManager: SessionManager {
        dependencyContainer.sessionManager
    }

    var body: some View {
        Group {
            switch sessionManager.state {
            case .initializing:
                ProgressView("Loading...")

            case .active:
                RootTabView()
                    .tint(.primaryColor)

            case .noAthlete:
                OnboardingView()
            }
        }
        .onAppear {
            sessionManager.verifySession()
        }
        // TODO: If going with iPadOS/macOS, there we shift towards other UI
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

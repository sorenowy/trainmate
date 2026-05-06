import SwiftData
import SwiftUI

struct MainView: View {
    private let dependencyContainer: any DIContainer
    
    private let sessionManager: SessionManager

    @State private var hasAthlete: Bool?
    
    var body: some View {
        Group {
            switch sessionManager.state {
            case .initializing:
                ProgressView("Loading...")
            case .active:
                RootTabView(dependencyContainer: dependencyContainer)
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
    
    init(dependencyContainer: any DIContainer) {
        self.dependencyContainer = dependencyContainer
        self.sessionManager = dependencyContainer.sessionManager
    }
}

#Preview("Preview with athlete") {
    MainView(dependencyContainer: AppDIContainer.previewWithAthlete)
}

#Preview("Preview no athlete in system") {
    MainView(dependencyContainer: AppDIContainer.previewEmpty)
}

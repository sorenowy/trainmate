import SwiftData
import SwiftUI

@main
struct TrainMateApp: App {
    private let dependencyContainer: any DIContainer = AppDIContainer()

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.diContainer, dependencyContainer)
        }
    }
}

import SwiftData
import SwiftUI

@main
struct TrainMateApp: App {
    @State private var appRouter = AppRouter()
    private let dependencyContainer: any DIContainer = AppDIContainer()

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(appRouter)
                .environment(\.diContainer, dependencyContainer)
        }
    }
}

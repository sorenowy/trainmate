import SwiftData
import SwiftUI

@main
struct TrainMateApp: App {
    
    @MainActor let dependencyContainer: any DIContainer = AppDIContainer()
    
    var body: some Scene {
        WindowGroup {
            MainView(dependencyContainer: dependencyContainer)
        }
    }
}

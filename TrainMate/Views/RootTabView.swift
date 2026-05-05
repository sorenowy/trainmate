import SwiftUI

struct RootTabView: View {
    @State private var router = AppRouter()
    
    private let dependencyContainer: any DIContainer
    
    var body: some View {
        TabView(selection: $router.selectedTab) {
            Tab("Home", systemImage: "house.fill", value: .dashboard) {
                AppCoordinatorView(path: $router.dashboardPath) {
                    DashboardView()
                }
            }
            Tab("Workout", systemImage: "figure.strengthtraining.functional.circle.fill", value: .workout) {
                AppCoordinatorView(path: $router.workoutPath) {
                    WorkoutView()
                }
            }
            Tab("History", systemImage: "gearshape.fill", value: .history) {
                AppCoordinatorView(path: $router.historyPath) {
                    HistoryView()
                }
            }
            Tab("Settings", systemImage: "list.clipboard.fill", value: .settings) {
                AppCoordinatorView(path: $router.settingsPath) {
                    SettingsView()
                }
            }
        }
        .tint(.primaryColor)
        .environment(router)
    }
    
    init(dependencyContainer: any DIContainer) {
        self.dependencyContainer = dependencyContainer
    }
}

#Preview {
    RootTabView(dependencyContainer: AppDIContainer())
}

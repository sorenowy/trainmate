import SwiftUI

struct RootTabView: View {
    @Environment(AppRouter.self) private var appRouter: AppRouter
    @Environment(\.diContainer) private var dependencyContainer: any DIContainer

    var body: some View {
        @Bindable var router = appRouter
        TabView(selection: $router.selectedTab) {
            Tab("Home", systemImage: "house.fill", value: .dashboard) {
                AppCoordinatorView(path: $router.dashboardPath) {
                    DashboardView(viewModel: DashboardViewModel(databaseClient: dependencyContainer.databaseClient))
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
    }
}

#Preview {
    RootTabView()
        .environment(AppRouter())
}

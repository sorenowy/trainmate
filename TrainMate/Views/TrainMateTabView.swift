//
//  TrainMateTabView.swift
//  TrainMate
//
//  Created by Hubert Kuszyński on 22/04/2026.
//

import SwiftUI

struct RootTabView: View {
    @State private var router = AppRouter()
    
    var body: some View {
        TabView(selection: $router.selectedTab) {
            Tab("Home", systemImage: "house.fill", value: .dashboard) {
                AppCoordinatorView(path: $router.dashboardPath) {
                    DashboardView()
                }
            }
            Tab("Workout", systemImage: "figure.strengthtraining.functional.circle.fill", value: .dashboard) {
                AppCoordinatorView(path: $router.workoutPath) {
                    WorkoutView()
                }
            }
            Tab("History", systemImage: "gearshape.fill", value: .dashboard) {
                AppCoordinatorView(path: $router.historyPath) {
                    HistoryView()
                }
            }
            Tab("Settings", systemImage: "list.clipboard.fill", value: .dashboard) {
                AppCoordinatorView(path: $router.settingsPath) {
                    SettingsView()
                }
            }
        }
        .tint(.primaryColor)
        .environment(router)
    }
}

#Preview {
    RootTabView()
}

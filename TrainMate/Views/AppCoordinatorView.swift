//
//  AppCoordinatorView.swift
//  TrainMate
//
//  Created by Hubert Kuszyński on 04/05/2026.
//

import SwiftUI

struct AppCoordinatorView<Content: View>: View {
    @Binding var path: NavigationPath
    @ViewBuilder let content: () -> Content
    
    var body: some View {
        NavigationStack(path: $path) {
            content()
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                    case .athleteProfile:
                        EmptyView()
                    case .languageSettings:
                        EmptyView()
                    case .notificationSettings:
                        EmptyView()
                    case .workoutDetails(let _):
                        EmptyView() // TODO: Create views
                    }
                }
        }
    }
}

#Preview("Dashboard - Start") {
    @Previewable @State var path = NavigationPath()
    
    AppCoordinatorView(path: $path) {
        DashboardView()
    }
    .environment(AppRouter())
}

#Preview("Workout - Start") {
    @Previewable @State var path = NavigationPath()
    
    AppCoordinatorView(path: $path) {
        WorkoutView()
    }
    .environment(AppRouter())
}

#Preview("History - Start") {
    @Previewable @State var path = NavigationPath()
    
    AppCoordinatorView(path: $path) {
        HistoryView()
    }
    .environment(AppRouter())
}

#Preview("Settings - Start") {
    @Previewable @State var path = NavigationPath()
    
    AppCoordinatorView(path: $path) {
        SettingsView()
    }
    .environment(AppRouter())
}

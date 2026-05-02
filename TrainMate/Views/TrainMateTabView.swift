//
//  TrainMateTabView.swift
//  TrainMate
//
//  Created by Hubert Kuszyński on 22/04/2026.
//

import SwiftUI

struct TrainMateTabView: View {
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house.fill") {
                NavigationStack {
                    DashboardView()
                }
            }
            Tab("Workout", systemImage: "figure.strengthtraining.functional.circle.fill") {
                NavigationStack {
                    WorkoutView()
                }
            }
            Tab("Settings", systemImage: "gearshape.fill") {
                NavigationStack {
                    SettingsView()
                }
            }
        }
        .tint(Color.primaryColor)
    }
}

#Preview {
    TrainMateTabView()
}

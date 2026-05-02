//
//  SettingsView.swift
//  TrainMate
//
//  Created by Hubert Kuszyński on 23/04/2026.
//

import os
import SwiftUI

struct SettingsView: View, Logging {
    @State private var viewModel = SettingsStore()

    var workout = Workout(name: "Test workout")

    var body: some View {
        NavigationView {
            List {
                Text(workout.name)
                Text("Item")
                Text("Item")
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
        }
        .onAppear {
            Logger.ui.info("[\(self.typeName)] Settings View Appeared")
        }
    }
}

#Preview {
    SettingsView()
}

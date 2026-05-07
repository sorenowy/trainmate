//
//  AppRouter.swift
//  TrainMate
//
//  Created by Hubert Kuszyński on 04/05/2026.
//

import os
import SwiftUI

enum AppTab: Hashable {
    case settings
    case dashboard
    case workout
    case history
}

enum AppRoute: Hashable {
    case workoutDetails(workoutId: UUID)
    case notificationSettings
    case athleteProfile
    case languageSettings
}

@Observable
final class AppRouter: Logging {
    // MARK: - Properties

    var selectedTab: AppTab = .dashboard

    var dashboardPath = NavigationPath()
    var workoutPath = NavigationPath()
    var settingsPath = NavigationPath()
    var historyPath = NavigationPath()

    // MARK: - Router API

    func navigate(to route: AppRoute) {
        switch selectedTab {
        case .settings:
            settingsPath.append(route)
        case .dashboard:
            dashboardPath.append(route)
        case .workout:
            workoutPath.append(route)
        case .history:
            historyPath.append(route)
        }
    }

    func returnToPrevious() {
        switch selectedTab {
        case .settings:
            guard !settingsPath.isEmpty else {
                Logger.app.error("[\(self.typeName)] SettingsPath tried to pop from empty settings stack.")
                return
            }
            settingsPath.removeLast()
        case .dashboard:
            guard !dashboardPath.isEmpty else {
                Logger.app.error("[\(self.typeName)] DashboardPath tried to pop from empty dashboard stack.")
                return
            }
            dashboardPath.removeLast()
        case .workout:
            guard !workoutPath.isEmpty else {
                Logger.app.error("[\(self.typeName)] WorkoutPath tried to pop from empty workout stack.")
                return
            }
            workoutPath.removeLast()
        case .history:
            guard !historyPath.isEmpty else {
                Logger.app.error("[\(self.typeName)] HistoryPath tried to pop from empty history stack.")
                return
            }
            historyPath.removeLast()
        }
    }

    func returnToRoot(to tab: AppTab?) {
        settingsPath.removeLast(settingsPath.count)
        dashboardPath.removeLast(dashboardPath.count)
        workoutPath.removeLast(workoutPath.count)
        historyPath.removeLast(historyPath.count)

        guard let tab else {
            Logger.app.warning("[\(self.typeName)] No tab to return to. Returning to current one.")
            return
        }
        selectedTab = tab
    }
}

//
//  DashboardView.swift
//  TrainMate
//
//  Created by Hubert Kuszyński on 23/04/2026.
//

import SwiftData
import SwiftUI

struct DashboardView: View {
    @Environment(AppRouter.self) private var router
    @Environment(\.diContainer) private var dependencyContainer: any DIContainer

    private var userName: String {
        let value: String
        do {
            value = try dependencyContainer.databaseClient.fetch(FetchDescriptor<Athlete>()).first?.name ?? "Anonymous"
        } catch {
            return "Error"
        }
        return value // TODO: REMOVE
    }

    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()

            VStack(spacing: .tmSpacing.small) {
                headerView
                Text(verbatim: "Dashboard View!")
                    .font(.tmTitle2)
                    .foregroundStyle(.primaryText)
                Text(verbatim: "Another line of title data")
                    .font(.tmTitle3)
                    .padding(.vertical, .tmSpacing.xlarge)
                Text(verbatim: "Some headline")
                    .font(.tmHeadline)
                Text(verbatim: "Some body text")
                    .font(.tmBody)
                Text(verbatim: "Some smaller text")
                    .font(.tmCallout)
                Text(verbatim: "Some ideal smaller even")
                    .font(.tmCaption)
                Text(verbatim: "Some ideal xtra smaller even")
                    .font(.tmCaptionSmall)

                Text(verbatim: "9876542")
                    .font(.tmMetric)
                Text(verbatim: "1235")
                    .font(.tmMetricSmall)

                Button("Navigate to some view") {
                    router.navigate(to: .athleteProfile)
                }
            }
            .navigationTitle(L10n.Dashboard.greeting(name: userName))
        }
    }

    var headerView: some View {
        Text(verbatim: "HRV")
            .font(.tmTitle1)
    }
}

#Preview {
    DashboardView()
        .environment(AppRouter())
}

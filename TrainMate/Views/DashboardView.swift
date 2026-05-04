//
//  DashboardView.swift
//  TrainMate
//
//  Created by Hubert Kuszyński on 23/04/2026.
//

import SwiftUI

struct DashboardView: View {
    @Environment(AppRouter.self) private var router
    
    private let userName: String = "Hubert"

    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()

            VStack(spacing: .tmSpacing.small) {
                headerView
                Text("Dashboard View!")
                    .font(.tmTitle2)
                    .foregroundStyle(.primaryText)
                Text("Another line of title data")
                    .font(.tmTitle3)
                    .padding(.vertical, .tmSpacing.xlarge)
                Text("Some headline")
                    .font(.tmHeadline)
                Text("Some body text")
                    .font(.tmBody)
                Text("Some smaller text")
                    .font(.tmCallout)
                Text("Some ideal smaller even")
                    .font(.tmCaption)
                Text("Some ideal xtra smaller even")
                    .font(.tmCaptionSmall)

                Text("9876542")
                    .font(.tmMetric)
                Text("1235")
                    .font(.tmMetricSmall)

                Button("Navigate to some view"){
                    router.navigate(to: .athleteProfile)
                }
            }
            .navigationTitle("Hello, \(userName)!")
        }
    }

    var headerView: some View {
        Text("HRV")
            .font(.tmTitle1)
    }
}

#Preview {
    DashboardView()
        .environment(AppRouter())
}

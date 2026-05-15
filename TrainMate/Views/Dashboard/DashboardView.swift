//
//  DashboardView.swift
//  TrainMate
//
//  Created by Hubert Kuszyński on 15/05/2026.
//

import SwiftUI

struct DashboardView: View {
    @Environment(\.diContainer) private var diContainer: any DIContainer
    @Environment(AppRouter.self) private var appRouter: AppRouter
    
    @State private var viewModel: DashboardViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: .tmSpacing.large) {
                if case .loading = viewModel.state {
                    ProgressView("Loading metrics..")
                } else {
                    HStack(spacing: .tmSpacing.medium) {
                        ReadinessCard(score: viewModel.readinessScore)
                        FTPCard(ftp: viewModel.currentFTP)
                        VO2MaxCard(vo2Max: viewModel.currentVO2Max)
                    }
                    
                    VStack(alignment: .leading) {
                        Text(verbatim: "HRV Variable (7Day)")
                            .font(.tmHeadline)
                        
                        RoundedRectangle(cornerRadius: .tmSpacing.small)
                            .fill(Color.secondaryColor.opacity(0.1))
                            .frame(height: 200)
                            .overlay(Text(verbatim: "here goes swiftcharts").foregroundStyle(Color.tertiaryColor))
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Dashboard")
    }
    
    init(viewModel: DashboardViewModel) {
        self.viewModel = viewModel
    }
}

#Preview {
    let container = MockDIContainer()
    DashboardView(viewModel: DashboardViewModel(databaseClient: container.databaseClient))
        .environment(AppRouter())
}

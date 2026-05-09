//
//  AthleteDataFormOnboardingView.swift
//  TrainMate
//
//  Created by Hubert Kuszyński on 08/05/2026.
//

import SwiftUI

struct AthleteDataFormOnboardingView: View {
    @State private var viewModel: AthleteDataFormOnboardingViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: .tmSpacing.xlarge) {
                Text(verbatim: "some title")
                    .font(.tmTitle2)
                    .foregroundStyle(Color.secondaryTextColor)
                    .padding(.horizontal, .tmSpacing.small)

                VStack(alignment: .leading, spacing: .tmSpacing.medium) {
                    Text(verbatim: "personal info section")
                        .font(.tmTitle3)
                        .foregroundStyle(Color.secondaryTextColor)
                        .padding(.horizontal, .tmSpacing.small)

                    VStack {
                        TextField("placeholder_1", text: $viewModel.athlete.name)
                            .padding()
                            .foregroundStyle(Color.primaryTextColor)

                        Divider().background(Color.dividerColor)

                        DatePicker(
                            "birth_date_picker",
                            selection: $viewModel.athlete.birthDate,
                            displayedComponents: .date
                        )
                        .padding()
                        .foregroundStyle(Color.primaryTextColor)
                    }
                    .background(Color.surfaceColor)
                    .cornerRadius(.tmSpacing.medium)
                }

                VStack(alignment: .leading, spacing: .tmSpacing.medium) {
                    Text(verbatim: "metrics_section")
                        .font(.tmTitle3)
                        .foregroundStyle(Color.secondaryTextColor)
                        .padding(.horizontal, .tmSpacing.small)

                    VStack {
                        Button(action: { Task { try await viewModel.syncWithHealthKit() } }, label: {
                            HStack {
                                if viewModel.isLoading {
                                    ProgressView()
                                        .tint(Color.backgroundColor)
                                        .padding(.trailing, .tmSpacing.small)
                                } else {
                                    Image(systemName: "heart.text.square.fill")
                                }
                                Text(verbatim: "sync_with_hk")
                                    .font(.tmHeadline)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.tmBody.bold())
                            }
                            .foregroundStyle(Color.backgroundColor)
                            .padding(.tmSpacing.medium)
                            .background(Color.primaryColor)
                            .cornerRadius(.tmSpacing.medium)
                        })
                        .disabled(viewModel.isLoading)

                        Divider().background(Color.dividerColor)

                        HStack {
                            Text(verbatim: "weight_label")
                                .foregroundStyle(Color.primaryTextColor)
                            Spacer()
                            TextField("0", value: $viewModel.athlete.weight, format: .number)
                                .keyboardType(.decimalPad)
                                .multilineTextAlignment(.trailing)
                                .foregroundStyle(Color.primaryTextColor)
                                .frame(width: 80)

                            Text("kg")
                                .foregroundStyle(Color.secondaryTextColor)
                        }
                        .padding()

                        HStack {
                            Text(verbatim: "height_label")
                                .foregroundStyle(Color.primaryTextColor)
                            Spacer()
                            TextField("0", value: $viewModel.athlete.weight, format: .number)
                                .keyboardType(.decimalPad)
                                .multilineTextAlignment(.trailing)
                                .foregroundStyle(Color.primaryTextColor)
                                .frame(width: 80)

                            Text("cm")
                                .foregroundStyle(Color.secondaryTextColor)
                        }
                        .padding()
                    }
                    .background(Color.surfaceColor)
                    .cornerRadius(.tmSpacing.medium)

                    Text(verbatim: "footer_info_hk")
                        .font(.tmCaption)
                        .foregroundStyle(Color.secondaryTextColor)
                        .padding(.horizontal, .tmSpacing.small)
                }

                Spacer(minLength: 20)

                Button(action: {}, label: {
                    Text(verbatim: "finish_onboarding_btn")
                        .font(.tmHeadline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.primaryColor)
                        .foregroundStyle(Color.backgroundColor)
                        .cornerRadius(.tmSpacing.medium)
                })
                .disabled(!viewModel.isReady)
                .padding(.bottom, .tmSpacing.xlarge)
            }
            .padding([.horizontal, .top], .tmSpacing.large)
        }
        .background(Color.backgroundColor.ignoresSafeArea())
        .scrollDismissesKeyboard(.interactively)
        .alert("Sync Error", isPresented: $viewModel.isError, presenting: viewModel.error) {
            _ in
            Button("Acknowledged", role: .cancel) {}
        } message: { error in
            Text(error.localizedDescription)
        }
    }

    init(viewModel: AthleteDataFormOnboardingViewModel) {
        self.viewModel = viewModel
    }
}

#Preview {
    let container = MockDIContainer()
    AthleteDataFormOnboardingView(viewModel: AthleteDataFormOnboardingViewModel(
        readDatabaseClient: container.databaseClient,
        writeDatabaseClient: container.backgroundDatabaseClient,
        healthKitClient: container.healthKitClient
    ))
}

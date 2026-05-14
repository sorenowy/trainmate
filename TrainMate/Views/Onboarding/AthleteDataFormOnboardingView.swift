//
//  AthleteDataFormOnboardingView.swift
//  TrainMate
//
//  Created by Hubert Kuszyński on 08/05/2026.
//

import os
import SwiftUI

struct AthleteDataFormOnboardingView: View, Logging {
    @Environment(AppRouter.self) private var appRouter: AppRouter
    @State private var viewModel: AthleteDataFormOnboardingViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: .tmSpacing.xlarge) {
                Text(L10n.Onboarding.onboardingAthletePageTitle)
                    .font(.tmTitle2)
                    .foregroundStyle(Color.secondaryTextColor)
                    .padding(.horizontal, .tmSpacing.small)

                headerView

                metricsView

                Spacer(minLength: 20)

                Button(action: {
                    Task { await viewModel.finishAthleteSetup() }
                }, label: {
                    Text(L10n.Onboarding.onboardingAthleteFinishButton)
                        .font(.tmHeadline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(viewModel.isReady ? Color.primaryColor : Color.secondaryColor)
                        .foregroundStyle(viewModel.isReady ? Color.backgroundColor : Color.secondaryTextColor)
                        .cornerRadius(.tmSpacing.medium)
                })
                .disabled(!viewModel.isReady)
                .opacity(!viewModel.isReady ? 0.3 : 1.0)
                .padding(.bottom, .tmSpacing.xlarge)
            }
            .padding([.horizontal, .top], .tmSpacing.large)
        }
        .background(Color.backgroundColor.ignoresSafeArea())
        .scrollDismissesKeyboard(.interactively)
        .alert("Sync Error", isPresented: $viewModel.isError, presenting: viewModel.error) { _ in
            Button(L10n.acknowledgeButtonTitle, role: .cancel) {}
        } message: { error in
            Text(error.localizedDescription)
        }
        .onChange(of: viewModel.state) {
            if viewModel.state == .completed {
                appRouter.switchRoot(to: .mainApp)
            }
        }
    }

    private var headerView: some View {
        VStack(alignment: .leading, spacing: .tmSpacing.medium) {
            Text(L10n.Onboarding.onboardingAthletePagePersonalDataTitle)
                .font(.tmTitle3)
                .foregroundStyle(Color.secondaryTextColor)
                .padding(.horizontal, .tmSpacing.small)

            VStack {
                TextField(L10n.Onboarding.onboardingAthletePageNameLabel, text: $viewModel.athlete.name)
                    .padding()
                    .foregroundStyle(Color.primaryTextColor)

                Divider().background(Color.dividerColor)

                DatePicker(
                    L10n.Onboarding.onboardingAthleteDateLabel,
                    selection: $viewModel.athlete.birthDate,
                    displayedComponents: .date
                )
                .padding(.horizontal, .tmSpacing.medium)
                .padding(.vertical, .tmSpacing.small)
                .foregroundStyle(Color.primaryTextColor)

                Divider().background(Color.dividerColor)

                HStack {
                    Text(L10n.Onboarding.onboardingAthleteSexLabel)
                        .foregroundStyle(Color.primaryTextColor)

                    Spacer()

                    Picker("bio_sex_label", selection: $viewModel.athlete.biologicalSex) {
                        ForEach(UserSex.allCases, id: \.self) { sex in
                            Text(String(localized: sex.localizedDescription)).tag(sex)
                        }
                    }
                    .pickerStyle(.menu)
                    .tint(Color.primaryTextColor)
                }
                .padding(.horizontal, .tmSpacing.medium)
                .padding(.top, .tmSpacing.small)
                .padding(.bottom, .tmSpacing.medium)
            }
            .background(Color.surfaceColor)
            .cornerRadius(.tmSpacing.medium)
        }
    }

    private var metricsView: some View {
        VStack(alignment: .leading, spacing: .tmSpacing.medium) {
            Text(L10n.Onboarding.onboardingAthleteMetricsTitle)
                .font(.tmTitle3)
                .foregroundStyle(Color.secondaryTextColor)
                .padding(.horizontal, .tmSpacing.small)

            VStack {
                Button(action: { Task { try await viewModel.syncWithHealthKit() } }, label: {
                    HStack {
                        if viewModel.state == .loading {
                            ProgressView()
                                .tint(Color.backgroundColor)
                                .padding(.trailing, .tmSpacing.small)
                        } else {
                            Image(systemName: "heart.text.square.fill")
                        }
                        Text(L10n.Onboarding.onboardingAthletePageHealthKitButton)
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
                .disabled(viewModel.state == .loading)

                Divider().background(Color.dividerColor)

                HStack {
                    Text(L10n.Onboarding.onboardingAthleteWeightLabel)
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
                    Text(L10n.Onboarding.onboardingAthleteHeightLabel)
                        .foregroundStyle(Color.primaryTextColor)
                    Spacer()
                    TextField("0", value: $viewModel.athlete.height, format: .number)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .foregroundStyle(Color.primaryTextColor)
                        .frame(width: 80)

                    Text("cm")
                        .foregroundStyle(Color.secondaryTextColor)
                }
                .padding()

                vo2MaxFtpInputView
            }
            .background(Color.surfaceColor)
            .cornerRadius(.tmSpacing.medium)

            Text(L10n.Onboarding.onboardingAthleteFooter)
                .font(.tmCaption)
                .foregroundStyle(Color.secondaryTextColor)
                .padding(.horizontal, .tmSpacing.small)
        }
    }

    @ViewBuilder private var vo2MaxFtpInputView: some View {
        HStack {
            Text(L10n.Onboarding.onboardingAthleteVO2MaxLabel)
                .foregroundStyle(Color.primaryTextColor)
            Spacer()
            TextField("0", value: $viewModel.athlete.vo2Max, format: .number)
                .keyboardType(.decimalPad)
                .multilineTextAlignment(.trailing)
                .foregroundStyle(Color.primaryTextColor)
                .frame(width: 80)

            Text("ml/kg")
                .foregroundStyle(Color.secondaryTextColor)
        }
        .padding()

        HStack {
            Text(L10n.Onboarding.onboardingAthleteFTPLabel)
                .foregroundStyle(Color.primaryTextColor)
            Spacer()
            TextField("0", value: $viewModel.athlete.ftp, format: .number)
                .keyboardType(.decimalPad)
                .multilineTextAlignment(.trailing)
                .foregroundStyle(Color.primaryTextColor)
                .frame(width: 80)

            Text("W")
                .foregroundStyle(Color.secondaryTextColor)
        }
        .padding()
    }

    init(viewModel: AthleteDataFormOnboardingViewModel) {
        Logger.ui.info("[AthleteDataFormOnboardingView] UI Initialized")
        self.viewModel = viewModel
    }
}

#Preview {
    let container = MockDIContainer()
    AthleteDataFormOnboardingView(viewModel: AthleteDataFormOnboardingViewModel(
        readDatabaseClient: container.databaseClient,
        writeDatabaseClient: container.backgroundDatabaseClient,
        healthKitClient: container.healthKitClient,
        userSettings: container.userSettings,
        sessionManager: container.sessionManager
    ))
}

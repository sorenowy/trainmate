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
            VStack(spacing: .tmSpacing.large) {
                VStack(alignment: .leading, spacing: .tmSpacing.medium) {
                    Text(verbatim: "personal info section")
                        .font(.tmTitle2)
                        .foregroundStyle(Color.secondaryTextColor)
                        .padding(.horizontal, .tmSpacing.small)
                }

                VStack {
                    TextField("placeholder_1", text: $viewModel.athlete.name)
                        .padding()
                        .foregroundStyle(Color.primaryTextColor)

                    Divider().background(Color.dividerColor)

                    DatePicker("birth_date_picker", selection: $viewModel.athlete.birthDate, displayedComponents: .date)
                        .padding()
                        .foregroundStyle(Color.primaryTextColor)
                }
                .background(Color.surfaceColor)
                .cornerRadius(.tmSpacing.medium)

                VStack(alignment: .leading, spacing: .tmSpacing.medium) {
                    Text(verbatim: "metrics_section")
                        .font(.tmTitle3)
                        .foregroundStyle(Color.secondaryTextColor)
                        .padding(.horizontal, .tmSpacing.small)

                    VStack {
                        Button(action: {}) {
                            HStack {
                                Image(systemName: "heart.text.square.fill")
                                Text(verbatim: "sync_with_hk")
                                    .font(.tmHeadline)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.tmBody.bold())
                            }
                            .foregroundStyle(Color.backgroundColor)
                            .padding()
                            .background(Color.primaryColor)
                        }

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
                    }
                    .background(Color.surfaceColor)
                    .cornerRadius(.tmSpacing.medium)

                    Text(verbatim: "footer_info_hk")
                        .font(.tmCaption)
                        .foregroundStyle(Color.secondaryTextColor)
                        .padding(.horizontal, .tmSpacing.small)
                }

                Spacer(minLength: 20)

                Button(action: {}) {
                    Text(verbatim: "finish_onboarding_btn")
                        .font(.tmHeadline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.primaryColor)
                        .foregroundStyle(Color.primaryTextColor)
                        .cornerRadius(.tmSpacing.medium)
                }
                .disabled(false)
                .padding(.bottom, .tmSpacing.xlarge)
            }
            .padding([.horizontal, .top], .tmSpacing.large)
        }
        .background(Color.backgroundColor.ignoresSafeArea())
        .scrollDismissesKeyboard(.interactively)
    }

    init(viewModel: AthleteDataFormOnboardingViewModel) {
        self.viewModel = viewModel
    }
}

#Preview {
    let container = MockDIContainer()
    AthleteDataFormOnboardingView(viewModel: AthleteDataFormOnboardingViewModel(
        readDatabaseClient: container.databaseClient,
        writeDatabaseClient: container.backgroundDatabaseClient
    ))
}

//
//  OnboardingStepView.swift
//  TrainMate
//
//  Created by Hubert Kuszyński on 08/05/2026.
//

import SwiftUI

struct OnboardingStepView: View {
    let title: LocalizedStringResource
    let description: LocalizedStringResource
    let imageName: String

    var body: some View {
        VStack(spacing: .tmSpacing.xlarge) {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .foregroundStyle(Color.primaryColor)
                .symbolEffect(.bounce, options: .nonRepeating)

            VStack(spacing: .tmSpacing.medium) {
                Text(title)
                    .font(.tmTitle1)
                    .foregroundStyle(Color.primaryColor)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, .tmSpacing.large)

                Text(description)
                    .font(.tmBody)
                    .foregroundStyle(Color.secondaryTextColor)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, .tmSpacing.xlarge)
            }
        }
        .padding(.bottom, .tmSpacing.xxlarge)
        .background(Color.backgroundColor).ignoresSafeArea()
    }
}

#Preview("Polish - Page 1") {
    OnboardingStepView(
        title: L10n.Onboarding.onboardingPageOneTitle,
        description: L10n.Onboarding.onboardingPageOneDescription,
        imageName: "figure.run.circle.fill"
    )
    .environment(\.locale, .init(identifier: "pl"))
}

#Preview("German - Page 1") {
    OnboardingStepView(
        title: L10n.Onboarding.onboardingPageOneTitle,
        description: L10n.Onboarding.onboardingPageOneDescription,
        imageName: "figure.run.circle.fill"
    )
    .environment(\.locale, .init(identifier: "de"))
}

#Preview("French - Page 1") {
    OnboardingStepView(
        title: L10n.Onboarding.onboardingPageOneTitle,
        description: L10n.Onboarding.onboardingPageOneDescription,
        imageName: "figure.run.circle.fill"
    )
    .environment(\.locale, .init(identifier: "fr"))
}

#Preview("English - Page 1") {
    OnboardingStepView(
        title: L10n.Onboarding.onboardingPageOneTitle,
        description: L10n.Onboarding.onboardingPageOneDescription,
        imageName: "figure.run.circle.fill"
    )
    .environment(\.locale, .init(identifier: "en"))
}

//
//  OnboardingWelcomeView.swift
//  TrainMate
//
//  Created by Hubert Kuszyński on 03/05/2026.
//

import SwiftUI

struct OnboardingWelcomeView: View {
    var body: some View {
        VStack(spacing: .tmSpacing.small) {
            Text("HELLO!")
                .font(.tmTitle1)
                .foregroundStyle(.primaryText)
                .padding(Spacing.medium)

            Text("This is onboarding welcome screen.")
                .font(.tmBody)
                .foregroundStyle(.primaryText)
                .padding(Spacing.medium)
        }
    }
}

#Preview {
    OnboardingWelcomeView()
}

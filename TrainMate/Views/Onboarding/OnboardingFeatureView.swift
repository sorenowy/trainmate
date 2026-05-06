//
//  OnboardingFeatureView.swift
//  TrainMate
//
//  Created by Hubert Kuszyński on 03/05/2026.
//

import SwiftUI

struct OnboardingFeatureView: View {
    var body: some View {
        VStack(spacing: .tmSpacing.small) {
            Text(verbatim: "HELLO!")
                .font(.tmTitle1)
                .foregroundStyle(.primaryText)
                .padding(Spacing.medium)

            Text(verbatim: "This is onboarding feature screen.")
                .font(.tmBody)
                .foregroundStyle(.primaryText)
                .padding(Spacing.medium)
        }
    }
}

#Preview {
    OnboardingFeatureView()
}

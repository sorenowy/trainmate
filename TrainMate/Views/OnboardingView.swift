import os
import SwiftData
import SwiftUI

struct OnboardingView: View {
    @Environment(\.diContainer) private var diContainer: DIContainer
    @State private var currentPage = 0

    var body: some View {
        TabView(selection: $currentPage) {
            OnboardingStepView(
                title: L10n.Onboarding.onboardingPageOneTitle,
                description: L10n.Onboarding.onboardingPageOneDescription,
                imageName: "figure.run.circle.fill"
            )
            .tag(0)
            OnboardingStepView(
                title: L10n.Onboarding.onboardingPageTwoTitle,
                description: L10n.Onboarding.onboardingPageTwoDescription,
                imageName: "square.stack.3d.up.fill"
            )
            .tag(1)
            OnboardingStepView(
                title: L10n.Onboarding.onboardingPageThreeTitle,
                description: L10n.Onboarding.onboardingPageThreeDescription,
                imageName: "applewatch.radiowaves.left.and.right"
            )
            .tag(2)

            AthleteDataFormOnboardingView(viewModel: AthleteDataFormOnboardingViewModel(
                readDatabaseClient: diContainer.databaseClient,
                writeDatabaseClient: diContainer.backgroundDatabaseClient
            ))
            .tag(3)
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .animation(.easeInOut, value: currentPage)
        .background(Color.backgroundColor)
        .tint(.primaryColor)
    }
}

#Preview {
    OnboardingView()
        .modelContainer(.previewContainer)
}

import SwiftData
import SwiftUI

struct OnboardingReadyView: View {
    let store: OnboardingStore
    @State private var showFormSheet: Bool = false

    var body: some View {
        ZStack {
            Color.backgroundColor.ignoresSafeArea()

            VStack(spacing: .tmSpacing.small) {
                Spacer()
                Text(verbatim: "Are you ready?")
                    .font(.tmDisplay)

                Text(verbatim: "Create your profile and start training!")
                    .font(.tmBody)
                    .multilineTextAlignment(.center)

                Spacer()

                Button("Create profile") {
                    showFormSheet.toggle()
                }
                .buttonStyle(.glassProminent)
                .tint(.primaryColor)
                .padding(.vertical, .tmSpacing.large)
            }
            .padding(.tmSpacing.large)
            .sheet(isPresented: $showFormSheet) {
                OnboardingProfileSheet(store: store)
            }
        }
    }
}

#Preview {
    OnboardingReadyView(store: OnboardingStore())
        .modelContainer(.previewContainer)
}

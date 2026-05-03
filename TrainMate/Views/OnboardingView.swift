import os
import SwiftData
import SwiftUI

struct OnboardingView: View {
    @Environment(\.modelContext) private var context
    @State private var store = OnboardingStore()

    var body: some View {
        TabView(selection: $store.currentPage) {
            OnboardingWelcomeView()
                .tag(0)
            OnboardingFeatureView()
                .tag(1)
            OnboardingReadyView(store: store)
                .tag(2)
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .animation(.easeInOut, value: store.currentPage)
        .background(Color.backgroundColor)
        .task {
            store.loadContext(modelContext: context)
        }
    }
}

#Preview {
    OnboardingView()
        .modelContainer(.previewContainer)
}

import SwiftUI

struct OnboardingProfileSheet: View {
    @Bindable var store: OnboardingStore

    var body: some View {
        VStack(spacing: .tmSpacing.small) {
            Text(verbatim: "Hello, I'm Profile sheet!")
                .font(.tmTitle1)
                .foregroundStyle(.primaryText)
                .padding(.top, .tmSpacing.xlarge)

            Form {
                TextField("Name", text: $store.name)
                TextField("Weight", value: $store.weight, format: .number)
                TextField("Height", value: $store.height, format: .number)
                DatePicker("Birth date", selection: $store.birthDate, displayedComponents: .date)
            }
        }
    }
}

#Preview {
    OnboardingProfileSheet(store: OnboardingStore())
}

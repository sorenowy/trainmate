//
//  OnboardingProfileSheet.swift
//  TrainMate
//
//  Created by Hubert Kuszyński on 03/05/2026.
//

import SwiftUI

struct OnboardingProfileSheet: View {
    @Bindable var store: OnboardingStore

    var body: some View {
        Text("Hello, I'm Profile sheet!")
            .font(.tmTitle1)
            .foregroundStyle(.primaryText)
        Form {
            TextField("Name", text: $store.name)
            TextField("Weight", value: $store.weight, format: .number)
            TextField("Height", value: $store.height, format: .number)
            DatePicker("Birth date", selection: $store.birthDate, displayedComponents: .date)
        }
    }
}

#Preview {
    OnboardingProfileSheet(store: OnboardingStore())
}

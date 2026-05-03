//
//  MainView.swift
//  TrainMate
//
//  Created by Hubert Kuszyński on 23/04/2026.
//

import SwiftData
import SwiftUI

struct MainView: View {
    @Query private var athletes: [Athlete]

    private var athlete: Athlete? {
        athletes.first
    }

    var body: some View {
        if athlete != nil {
            // TODO: If going with iPadOS/macOS, there we shift towards other UI
            TrainMateTabView()
                .tint(Color.primaryColor)
        } else {
            OnboardingView()
        }
    }
}

#Preview {
    MainView()
}

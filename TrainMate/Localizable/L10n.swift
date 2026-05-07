//
//  L10n.swift
//  TrainMate
//
//  Created by Hubert Kuszyński on 06/05/2026.
//

import Foundation

enum L10n {
    enum Dashboard {
        static func greeting(name: String) -> String {
            let formatString = String(localized: "app.dashboard.greeting")
            return String(format: formatString, name)
        }
    }

    enum Workout {}
    enum History {}
    enum Settings {}

    static let appTitle = LocalizedStringResource("app.title")
}

//
//  Environment.swift
//  TrainMate
//
//  Created by Hubert Kuszyński on 07/05/2026.
//

import SwiftUI

private struct DIContainerEnvironmentKey: EnvironmentKey {
    static let defaultValue: any DIContainer = MockDIContainer()
}

extension EnvironmentValues {
    var diContainer: any DIContainer {
        get { self[DIContainerEnvironmentKey.self] }
        set { self[DIContainerEnvironmentKey.self] = newValue }
    }
}

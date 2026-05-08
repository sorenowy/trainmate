//
//  AthleteDataFormOnboardingViewModel.swift
//  TrainMate
//
//  Created by Hubert Kuszyński on 08/05/2026.
//

import Foundation
import SwiftUI

@Observable
@MainActor
final class AthleteDataFormOnboardingViewModel: Logging {
    private let readDatabaseClient: any DatabaseClientProtocol
    private let writeDatabaseClient: any BackgroundDatabaseClientProtocol

    var athlete: Athlete = .init()

    init(readDatabaseClient: any DatabaseClientProtocol, writeDatabaseClient: any BackgroundDatabaseClientProtocol) {
        self.readDatabaseClient = readDatabaseClient
        self.writeDatabaseClient = writeDatabaseClient
    }
}

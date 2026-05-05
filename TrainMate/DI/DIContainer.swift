//
//  DIContainer.swift
//  TrainMate
//
//  Created by Hubert Kuszyński on 05/05/2026.
//

import Foundation
import SwiftData
import os

protocol DIContainer {
    @MainActor var databaseClient: any DatabaseClientProtocol { get }
    @MainActor var sessionManager: SessionManager { get }
}

final class AppDIContainer: DIContainer, Logging {
    // DB ENGINE:
    private let modelContainer: ModelContainer = {
        do {
            let schema = Schema([
                Workout.self, Athlete.self
            ])
            let modelConfiguration = ModelConfiguration(
                schema: schema,
                isStoredInMemoryOnly: false,
                cloudKitDatabase: .automatic
            )
            
            return try ModelContainer(for: schema, configurations: modelConfiguration)
        } catch {
            Logger.database.error("[ModelContainer] Error while creating ModelContainer: \(error.localizedDescription)")
            fatalError(error.localizedDescription)
        }
    }()
    
    @MainActor
    lazy var databaseClient: any DatabaseClientProtocol = {
        DatabaseClient(context: modelContainer.mainContext)
    }()
    
    @MainActor
    lazy var sessionManager: SessionManager = {
        SessionManager(databaseClient: databaseClient)
    }()
}

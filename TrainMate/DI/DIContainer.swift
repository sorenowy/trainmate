import Foundation
import SwiftData
import os

protocol DIContainer {
    @MainActor var databaseClient: any DatabaseClientProtocol { get }
    @MainActor var sessionManager: SessionManager { get }
}

final class AppDIContainer: DIContainer, Logging {
    private let inMemory: Bool
    
    init(inMemory: Bool = false) {
        self.inMemory = inMemory
    }
    // DB ENGINE:
    lazy var modelContainer: ModelContainer = {
        do {
            let schema = Schema([
                Workout.self, Athlete.self
            ])
            let modelConfiguration = ModelConfiguration(
                schema: schema,
                isStoredInMemoryOnly: inMemory,
                cloudKitDatabase: inMemory ? .none : .automatic
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
    lazy var backgroundDatabaseClient: any BackgroundDatabaseClientProtocol = {
        BackgroundDatabaseClient(modelContainer: modelContainer)
    }()
    
    @MainActor
    lazy var sessionManager: SessionManager = {
        SessionManager(databaseClient: databaseClient)
    }()
}

extension AppDIContainer {
    static var previewWithAthlete: AppDIContainer {
        let container = AppDIContainer(inMemory: true)
        let athlete = Athlete(name: "Hubert Test")
        
        try? container.databaseClient.insert(athlete)
        try? container.databaseClient.save()
        
        return container
    }
    
    static var previewEmpty: AppDIContainer {
        let container = AppDIContainer(inMemory: true)

        return container
    }
}

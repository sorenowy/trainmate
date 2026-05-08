import Foundation
import os
import SwiftData

protocol DIContainer {
    @MainActor var databaseClient: any DatabaseClientProtocol { get }
    @MainActor var sessionManager: SessionManager { get }
    var backgroundDatabaseClient: any BackgroundDatabaseClientProtocol { get }
}

// MARK: - App Container

final class AppDIContainer: DIContainer, Logging {
    /// DB ENGINE:
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
    lazy var databaseClient: any DatabaseClientProtocol = DatabaseClient(context: modelContainer.mainContext)

    @MainActor
    lazy var backgroundDatabaseClient: any BackgroundDatabaseClientProtocol =
        BackgroundDatabaseClient(modelContainer: modelContainer)

    @MainActor
    lazy var sessionManager: SessionManager = .init(databaseClient: databaseClient)
}

// MARK: - Mock Container

final class MockDIContainer: DIContainer {
    init(hasAthlete: Bool = false) {
        if hasAthlete {
            let fakeAthlete = Athlete(name: "John", hrMax: 130)
            try? self.databaseClient.insert(fakeAthlete)
            try? self.databaseClient.save()
        }
    }

    private let modelContainer: ModelContainer = {
        do {
            let schema = Schema([
                Workout.self, Athlete.self
            ])
            let modelConfiguration = ModelConfiguration(
                schema: schema,
                isStoredInMemoryOnly: true,
            )

            return try ModelContainer(for: schema, configurations: modelConfiguration)
        } catch {
            Logger.database
                .error("[ModelContainer] Error while creating Mock ModelContainer: \(error.localizedDescription)")
            fatalError(error.localizedDescription)
        }
    }()

    @MainActor lazy var databaseClient: any DatabaseClientProtocol = DatabaseClient(context: modelContainer.mainContext)

    lazy var backgroundDatabaseClient: any BackgroundDatabaseClientProtocol =
        BackgroundDatabaseClient(modelContainer: modelContainer)

    @MainActor lazy var sessionManager: SessionManager = .init(databaseClient: databaseClient)
}

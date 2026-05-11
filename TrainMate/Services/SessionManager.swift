import Foundation
import os
import SwiftData

enum SessionState {
    case initializing
    case active
    case noAthlete
}

@Observable
final class SessionManager: Logging {
    private let databaseClient: any DatabaseClientProtocol

    private(set) var state: SessionState = .initializing

    init(databaseClient: any DatabaseClientProtocol) {
        self.databaseClient = databaseClient
        verifySession()
    }

    @MainActor
    func verifySession() {
        do {
            var descriptor = FetchDescriptor<Athlete>()
            descriptor.fetchLimit = 1

            let athletes: [Athlete] = try databaseClient.fetch(descriptor)

            self.state = athletes.isEmpty ? .noAthlete : .active
        } catch {
            Logger.database.error("[\(self.typeName)] Failed to fetch athletes: \(error.localizedDescription)")
            self.state = .noAthlete
        }
    }

    @MainActor
    func logOut() throws {
        self.state = .noAthlete
    }
}

//
//  BackgroundDatabaseClient.swift
//  TrainMate
//
//  Created by Hubert Kuszyński on 06/05/2026.
//

import Foundation
import SwiftData

protocol BackgroundDatabaseClientProtocol: Sendable {
    func createAthlete(name: String) async throws -> PersistentIdentifier
    func deleteAthlete(withId id: PersistentIdentifier) async throws
}

@ModelActor
actor BackgroundDatabaseClient: BackgroundDatabaseClientProtocol {
    func createAthlete(name: String) async throws -> PersistentIdentifier {
        let athlete = Athlete(name: name)
        modelContext.insert(athlete)
        
        try modelContext.save()
        
        return athlete.persistentModelID
    }
    
    func deleteAthlete(withId id: PersistentIdentifier) async throws {
        if let model = modelContext.model(for: id) as? Athlete {
            modelContext.delete(model)
            try modelContext.save()
        }
    }
}

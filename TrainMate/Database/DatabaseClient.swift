//
//  DatabaseClient.swift
//  TrainMate
//
//  Created by Hubert Kuszyński on 05/05/2026.
//

import Foundation
import SwiftData

protocol DatabaseClientProtocol: Sendable {
    @MainActor func fetch<T: PersistentModel>(_ descriptor: FetchDescriptor<T>) throws -> [T]
    @MainActor func delete<T: PersistentModel>(_ item: T) throws
    @MainActor func insert<T: PersistentModel>(_ item: T) throws
    @MainActor func save() throws
}

final class DatabaseClient: DatabaseClientProtocol {
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    @MainActor
    func fetch<T: PersistentModel>(_ descriptor: FetchDescriptor<T>) throws -> [T] where T : PersistentModel {
        return try context.fetch(descriptor)
    }
    
    @MainActor
    func insert<T: PersistentModel>(_ item: T) throws {
        context.insert(item)
    }
    
    @MainActor
    func delete<T: PersistentModel>(_ item: T) throws {
        context.delete(item)
    }
    
    @MainActor
    func save() throws {
        if context.hasChanges {
            try context.save()
        }
    }
}

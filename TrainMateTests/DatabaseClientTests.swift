//
//  DatabaseClientTests.swift
//  TrainMateTests
//
//  Created by Hubert Kuszyński on 07/05/2026.
//

import Foundation
import SwiftData
import Testing
@testable import TrainMate

@Suite("[Unit] Database Client Operations")
@MainActor
struct DatabaseClientTests {
    let inMemoryContainer: ModelContainer
    let sut: DatabaseClient

    init() throws {
        let schema = Schema([Athlete.self, Workout.self])
        let config = ModelConfiguration(isStoredInMemoryOnly: true)

        self.inMemoryContainer = try ModelContainer(for: schema, configurations: config)
        self.sut = .init(context: inMemoryContainer.mainContext)
    }

    @Test("Should insert, save and fetch athlete successfully")
    func insertAthleteAndFetch() throws {
        // Act
        let newAthlete = Athlete(name: "Bogdan")
        try sut.insert(newAthlete)
        try sut.save()

        // Assert
        let descriptor = FetchDescriptor<Athlete>()
        let fetchedAthletes = try sut.fetch(descriptor)

        #expect(fetchedAthletes.count == 1, "Bogdan is not in the database")
        #expect(fetchedAthletes.first?.name == "Bogdan", "Name does not exist in DB")
    }

    @Test("Should delete athlete successfully")
    func deleteAthlete() throws {
        let newAthlete = Athlete(name: "Bogdan")
        try sut.insert(newAthlete)
        try sut.save()

        try sut.delete(newAthlete)
        try sut.save()

        let descriptor = FetchDescriptor<Athlete>()
        let fetchedAthletes = try sut.fetch(descriptor)

        #expect(fetchedAthletes.isEmpty, "Athlete is still in the database")
    }
}

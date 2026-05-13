//
//  SessionManagerTests.swift
//  TrainMateTests
//
//  Created by Hubert Kuszyński on 07/05/2026.
//

import Foundation
import Testing
@testable import TrainMate

@Suite("[Unit] Session Manager Logic")
@MainActor
struct SessionManagerTests {
    @Test("Should change state to Active when athlete exists in database")
    func verifySessionWithExistingAthlete() throws {
        let container = MockDIContainer(hasAthlete: true)
        let sut = SessionManager(databaseClient: container.databaseClient)

        try sut.verifySession()

        #expect(sut.state == .active, "Session Manager is not set as active")
    }

    @Test("Should change to No Athlete, when database is empty after verification")
    func verifySessionWithNoAthlete() throws {
        let container = MockDIContainer(hasAthlete: false)
        let sut = SessionManager(databaseClient: container.databaseClient)

        try sut.verifySession()

        #expect(sut.state == .noAthlete, "Session Manager should be set as No Athlete")
    }
}

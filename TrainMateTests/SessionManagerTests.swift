//
//  SessionManagerTests.swift
//  TrainMateTests
//
//  Created by Hubert Kuszyński on 07/05/2026.
//

import Foundation
import Testing
@testable import TrainMate

@Suite("Session Manager Logic")
@MainActor
struct SessionManagerTests {
    @Test("Should set state to initializing when its instantiated")
    func verifyInitialSession() {
        let container = MockDIContainer(hasAthlete: true)
        let sut = SessionManager(databaseClient: container.databaseClient)

        #expect(sut.state == .initializing, "State should be set to initializing upon init")
    }

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

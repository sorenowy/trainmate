import Testing
import SwiftData
import Foundation
@testable import TrainMate

@Suite("Background Database Operations")
struct BackgroundDatabaseClientTests {
    let inMemoryContainer: ModelContainer
    let sut: BackgroundDatabaseClient
    
    init() throws {
        let schema = Schema([Athlete.self, Workout.self])
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        
        self.inMemoryContainer = try ModelContainer(for: schema, configurations: config)
        self.sut = BackgroundDatabaseClient(modelContainer: inMemoryContainer)
    }
    
    @Test("Should correctly create and save an athlete",
    arguments: [
        "Hubert",
        "Jan Kowalski",
        "John Connor",
        "" // edge case
    ])
    func createAthleteSuccessfully(name: String) async throws {
        // Act
        let athleteId = try await sut.createAthlete(name: name)
        
        // Assert
        let validationContext = ModelContext(inMemoryContainer)
        let fetchedAthlete = validationContext.model(for: athleteId) as? Athlete
        
        #expect(fetchedAthlete != nil, "Actor did not saved Athlete in DB")
        #expect(fetchedAthlete?.name == name, "Saved name is not the proper one provided in parameter")
    }
    
    @Test("Should delete athlete by ID and remove it from db context")
    func deleteAthleteSuccessfully() async throws {
        let idToDelete = try await sut.createAthlete(name: "Joe")
                
        try await sut.deleteAthlete(withId: idToDelete)
        
        let freshValidationContext = ModelContext(inMemoryContainer)
        let descriptor = FetchDescriptor<Athlete>()
        
        let allAthletes = try freshValidationContext.fetch(descriptor)
        
        let stillExists = allAthletes.contains{ $0.persistentModelID == idToDelete }
        
        #expect(stillExists == false, "Athlete was not removed from db")
        #expect(allAthletes.isEmpty, "Database should be pristine")
    }
}

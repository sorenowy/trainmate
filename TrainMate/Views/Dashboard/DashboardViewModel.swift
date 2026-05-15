import Foundation
import SwiftUI
import SwiftData
import os

@MainActor
@Observable
final class DashboardViewModel: Logging {
    enum State {
        case idle
        case loading
        case failure(Error)
    }
    
    let databaseClient: any DatabaseClientProtocol
    
    var athlete: Athlete? = nil
    var state: State = .idle
    var hrvData: [Double] = []
    var currentFTP: Int = 0
    var currentVO2Max: Double = 0
    var readinessScore: Int = 100
    
    init(databaseClient: any DatabaseClientProtocol) {
        self.databaseClient = databaseClient
        Logger.app.info("[\(self.typeName)] initialized.")
    }
    
    func fetchDashboardData() async {
        state = .loading
        
        do {
            let descriptor = FetchDescriptor<Athlete>()
            let athletes = try databaseClient.fetch(descriptor)
            athlete = athletes.first
            state = .idle
            calculateReadiness()
        } catch {
            state = .failure(error)
        }
    }
    
    private func calculateReadiness() {
        self.readinessScore = 80
    }
}

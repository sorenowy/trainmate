//
//  ModelContainer+Preview.swift
//  TrainMate
//
//  Created by Hubert Kuszyński on 03/05/2026.
//

import SwiftData

extension ModelContainer {
    static var previewContainer: ModelContainer {
        let schema = Schema([
            Workout.self, Athlete.self
        ])
        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: true,
        )
        return try! ModelContainer(for: schema, configurations: [modelConfiguration])
    }
}

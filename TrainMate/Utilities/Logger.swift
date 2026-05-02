//
//  Logger.swift
//  TrainMate
//
//  Created by Hubert Kuszyński on 28/04/2026.
//

import Foundation
import os

public extension Logger {
    private static let subsystem = Bundle.main.bundleIdentifier ?? "com.example.TrainMate"

    static let app = Logger(subsystem: subsystem, category: "App")
    static let network = Logger(subsystem: subsystem, category: "Network")
    static let ui = Logger(subsystem: subsystem, category: "UI")
    static let database = Logger(subsystem: subsystem, category: "DB")
}

public protocol Logging {
    var typeName: String { get }
}

public extension Logging {
    var typeName: String {
        String(describing: type(of: self))
    }
}

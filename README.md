# TrainMate


## Tech Stack

| Layer | Technology |
|---|---|
| UI | SwiftUI, @Observable |
| Data | SwiftData, CloudKit *(planned)* |
| Health | HealthKit |
| Wearable | WatchKit *(planned)* |
| Monetization | StoreKit 2 *(planned)* |
| ML | Core ML *(planned)* |
| DI | DIContainer via EnvironmentKey |
| Logging | OSLog (subsystem/category) |
| Linting | SwiftLint, SwiftFormat |
| CI/CD | GitHub Actions |

## Architecture

TrainMate uses a layered architecture with clear separation of concerns:
┌─────────────────────────────────┐
│           Presentation          │
│     SwiftUI Views + @Observable │
│           ViewModels            │
├─────────────────────────────────┤
│            Domain               │
│     DTOs · Services, Router     │
├─────────────────────────────────┤
│             Data                │
│  DatabaseClient · HealthKit     │
│  Client, SessionManager, Entity │
└─────────────────────────────────┘

Dependency injection is handled via `DIContainer` registered as an `EnvironmentKey`,
allowing views to access services without tight coupling.
Navigation uses per-tab `NavigationStack` with typed `AppRoute` enum.

## How to run?

Simply use make setup. :)

## Code Rules

### Convention in TrainMate:
1. @PropertyWrappers
2. Static Properties via ACL (public, internal, private(set), private)
3. Stored Properties via ACL (public, internal, private(set), private)
4. Computed properties via ACL
5. Functions via ACL
6. Extensions via ACL

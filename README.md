# Flutter MVVM App Architecture

This project implements the application architecture guidelines described in Flutter's official architecture case study. It follows an MVVM-based UI layer combined with repositories and services in the data layer to create a scalable, maintainable Flutter application structure.

This repository is intended for learning, architectural reference, and portfolio demonstration purposes.

---

## Architecture Overview

This project follows the architectural principles outlined in Flutter's App Architecture Case Study:

- MVVM pattern in the UI layer
- ChangeNotifier / Listenable-based state management
- Repository pattern for data access
- Service layer for API and external communication
- Dependency Injection using Provider
- Clear separation of concerns across layers

The architecture separates responsibilities into distinct layers:

### UI Layer (Feature-Based)
- Views (Screens & Widgets)
- ViewModels (ChangeNotifier)
- Feature-specific organization

### Domain Layer
- Pure data models
- Business entities shared across layers
- No Flutter dependencies

### Data Layer
- Repositories (coordinate data flow)
- Services (API / local storage communication)
- API models if needed

---

## Folder Structure
```
lib/
├── ui/
│   ├── core/                   # Shared UI components & themes
│   └── <feature_name>/
│       ├── view_models/        # Feature ViewModels
│       └── widgets/            # Feature screens & widgets
│
├── domain/
│   └── models/                 # Application data models
│
├── data/
│   ├── repositories/           # Data coordination layer
│   └── services/               # API & external services
│
├── config/                     # Environment configuration
├── routing/                    # App routing
├── utils/                      # Utilities & helpers
├── main.dart                   # Production entry point
├── main_development.dart       # Development entry point
└── main_staging.dart           # Staging entry point
```

> Test structure mirrors `lib/` to maintain clear separation of unit and widget tests.

---

## Key Concepts Demonstrated

- Feature-based UI organization
- ViewModel-driven UI updates
- Safe state updates using ChangeNotifier
- Repository abstraction over services
- Dependency Injection via Provider
- Environment-based app entry points
- Scalable project structure for large applications

---

## Tech Stack

- Flutter
- Dart
- Provider (Dependency Injection & State)
- ChangeNotifier / Listenable
- Repository Pattern
- MVVM Architectural Pattern

---

## Purpose

This project serves as:

- A reference implementation of Flutter's recommended architectural guidelines
- A template for building scalable Flutter applications
- A portfolio demonstration of architectural understanding

It is not a full production application, but the structure is production-ready and designed for extensibility.

---

## Getting Started

1. Clone the repository:
```bash
   git clone <repo-url>
```

2. Navigate to the project:
```bash
   cd flutter-mvvm-app-architecture
```

3. Install dependencies:
```bash
   flutter pub get
```

4. Run the application:
```bash
   flutter run
```

---

## Reference

Architecture inspired by Flutter's official App Architecture Case Study:
[https://docs.flutter.dev/app-architecture/case-study](https://docs.flutter.dev/app-architecture/case-study)
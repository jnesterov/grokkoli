# grokkoli

## Overview

grokkoli is a demo app created to validate SDK functionalities and illustrate proficiency in Swift/iOS software development and test. Designed with foundational testing components, state management, and user interface elements, it mirrors real-world requirements in health data tracking. The app focuses on simulating glucose monitoring, making it an effective tool for testing UI and state management in a health-related context.

## Technology Stack

- **Programming Language**: Swift
- **Framework**: SwiftUI for UI design, Combine for state management
- **Development Environment**: Xcode 15 or higher
- **Target Devices**: iOS Simulators and Physical Devices (iOS 17.5+)

## Dependencies

The project uses the following dependencies:

- **Combine**: Manages state updates and reactive programming for data flow within the app.
- **SwiftData**: Facilitates data persistence and retrieval for managing data.
- **SwiftUI**: Provides a declarative framework for building user interfaces.
- **Foundation**: Supplies data types, collections and basic functionality.


These dependencies enable seamless data handling and UI interaction in a structured, testable way.

## Prerequisites

- **Xcode**: Xcode 15 or higher.
- **iOS 17.5+**: For compatibility with the latest iOS features and updates.

## Setup Instructions

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/yourusername/grokkoli.git
   cd grokkoli
   ```

2. **Open in Xcode**:
   ```bash
   open grokkoli.xcodeproj
   ```

3. **Build and Run**:
   - Choose your target device or simulator in Xcode.
   - Press `Cmd + R` to build and run the app.

## Features

- **Dashboard View**: Displays the latest glucose reading, with options to fetch new readings for testing purposes.
- **Profile Management**: Allows users to view and manage profile information.
- **Simulated Glucose Data**: Generates random glucose levels, demonstrating data tracking without real data integration.
- **LogIn Functionality**: Provides a simple login interface for users, with preset credentials for testing purposes. To log in, use username: "TestUser" and password: "12345".
- **Logout Functionality**: Users can log out and return to the login screen.
- **Data Persistence Simulation**: Demonstrates how past data can be stored and displayed, simulating tracking functionality for health metrics.
- **Practical SDK Validation**:  Provides a real-world SDK testing scenarios where data persistence and retrieval would be essential, reinforcing the app’s testing objectives.
- **Testing-Friendly Design**: Structured with modular components to support testing, focusing on validating SDK functionalities.

## Project Architecture

### 1. `AppState` Class

- **Purpose**: Manages app-wide login state, providing a centralized way to handle login and logout.
- **Why It’s Needed**: Controls the navigation flow, ensuring a smooth user experience across screens.

### 2. `DashboardView` Class

- **Purpose**: Displays simulated glucose readings and allows users to fetch new readings.
- **Why It’s Needed**: Acts as the main interface for tracking glucose data and monitoring changes over time.

### 3. HistoryView Class
- **Purpose**: Displays a list of past glucose readings with timestamps, allowing users to view historical data.
- **Why It’s Needed**: Provides a way to track and analyze trends over time, simulating real-world data persistence and retrieval, which is essential for validating health data tracking functionality.

### 4. `ProfileView` Class

- **Purpose**: Allows users to manage profile information, enhancing personalization.
- **Why It’s Needed**: Offers a user-centric area for adjusting profile settings, improving usability.

### 5. `ProfileDisplayView` Class

- **Purpose**: Displays detailed user profile information, including name, date of birth, email, and phone number.
- **Why It’s Needed**: Provides a dedicated view for users to review their profile details, enhancing personalization and making user information accessible in an organized layout.

### 6. `Enums`

- **Purpose**: Categorizes glucose levels into meaningful labels (Normal, High, Low) with associated actions and display properties, for streamlined data handling.
- **Why It’s Needed**: Simplifies the handling and display of different glucose level statuses. The app triggers specific actions or apply distinct visual styles based on the reading's category.

### 7. `APIRequest Protocol`

- **Purpose**: The `APIRequest` protocol defines the structure for configuring an API request. Specifies properties: endpoint, HTTP method, headers, query parameters, and body, making it a standardized template for setting up requests. Secures consistency across different types of requests within the app.
- **Why It's Needed**: The `APIRequest` protocol allows us to define various requests in a reusable and maintainable way. Since it acts as a blueprint rather than a concrete implementation, it can be used  by any service that needs to create API requests. This separation of configuration (in `APIRequest`) and execution (in `APIService`) keeps simplified set up and allows test different request configurations.
- **Decoupling**: Decouples the request configuration from the request execution. Provides a standardized template for request properties. 

### 8. `APIService`

- **Purpose**: The `APIService` class is responsible for creating and executing API requests based on the configurations provided by the `APIRequest` protocol. It builds the `URLRequest` using details from `APIRequest`, sends the request, and handles the response. Additionally, it decodes the JSON response into the desired data model, great for data handling across the app.
- **How It Works**: The `APIService` accepts an instance of any `APIRequest`-conforming type, uses its properties to configure a `URLRequest`, and then performs the network request. After receiving the response, it checks for errors and decodes the JSON data into the specified data model to work with structured data.
- **Why It's Needed**: By handling the process of creating, sending, and decoding requests, `APIService` abstracts away the complexity of network operations. This design keeps other parts of the app clean and focused on their own functionality, as they don’t need to worry about network details. 
- **Decoupling**: The `APIService's` design achieves decoupling by separating the request configuration (handled by `APIRequest`) from the request execution (handled by `APIService`). This keeps the codebase modular, as new requests can be added or modified without changing `APIService`.

### 9. `Page Object Model (POM)` Class

- **Purpose**: Implements the Page Object Model design pattern to encapsulate app elements and interactions within dedicated page classes. This pattern enhances the test code's readability and maintainability by isolating UI elements and user actions.
- **How Dependency Injection is Used**: Each page object receives necessary dependencies (like test data or utility classes) at instantiation, allowing flexibility in modifying test data or interactions without altering the page objects directly. This structure promotes reusable, test-specific instances of each page class.

### 10. `BaseTest` Class

- **Purpose**: Provides a common setup and teardown process for all test classes, ensuring each test begins with the correct configurations and environment. `BaseTest` also manages shared resources, such as `AppState` instance.
- **Why It’s Needed**: Centralizes configuration, reducing redundancy and keeping test setup and teardown consistent across different test files. This setup simplifies changes to testing configurations by requiring only a single update within `BaseTest`.

### 11. Dedicated Test Files

- **Purpose**: Each test file targets specific app features or flows, such as `DashboardTests` for glucose reading functionality and `ProfileTests` for profile management.
- **Structure**: By organizing tests into feature-specific files, the project remains organized, with tests grouped logically by functionality, improving readability and maintenance.

### 12. Utility Classes

- **Purpose**: Provides helper methods for common actions, such as interacting with elements, data formatting, and validation. Utility classes include functions for data generation, navigation, and environment setup.
- **Examples**:
  - **WaitUtils**: Contains methods for explicit waits to handle dynamic elements, ensuring that interactions only occur once elements are fully loaded and ready.
  - **DataUtilities**: Supplies data formatting or transformation methods as needed by the test files.
  - **Appium Utilities (WIP)**: Appium driver configurations and lifecycle management across multiple test scenarios.
  - **API Manager**: Will handle API interactions, support test data setup and verification in integration tests.
- **Why They’re Important**: Utilities prevent code duplication by centralizing reusable methods, for tests to be concise and maintainable.


### 13. Dependency Injection Across Components

- **ProfileDisplayView**: Receives `UserProfile` data through dependency injection, making it modular and easily testable.
- **Page Object Model (POM)**: Injects dependencies, such as utility classes and configurations, at the object level, enhancing modularity and flexibility in test scenarios.
- **Test Files**: Test cases use injected dependencies, often through `BaseTest`, to access app state, configuration, and utilities without tight coupling to specific implementations.
- **CI/CD Integration (WIP)**: Currently under development to integrate automated build and deployment processes for testing efficiency and continuous integration.
- **APIServiceProtocol**: The use of dependency injection with allows for easy mocking and testing by injecting different implementations (mock API service) for testing purposes. Promotes clean separation of concerns within the app.

This architectural setup, combining POM with dependency injection, modularity, and utility classes, ensures grokkoli’s codebase is both flexible and test-friendly, supporting best automation testing practices and maintaining separation of concerns.

These classes work together to create testable user experience, focusing on health data simulation and app state management.

## Additional Features

- **State-Driven UI Updates**: Combines SwiftUI and Combine for dynamic UI based on app state.
- **Simulated Data**: Demonstrates data generation and display for glucose readings, supporting testable functionality.
- **Centralized Login Management**: Uses `AppState` for smooth login/logout transitions and consistent app behavior.

## Summary

- **Project Name**: grokkoli
- **Documentation**: This README provides setup instructions, usage details, and a clear overview of the project structure.
- **Purpose**: Demonstrate Swift proficiency through a health-focused data tracking app, designed for automation testing and SDK validation.

## License

This project is not licensed for public use. It was developed as a technical demonstration, and all intellectual property belongs to the creator. Redistribution, modification, or use of this project without explicit permission is prohibited. All rights are reserved

### Important:

These credentials are for demonstration purposes only and are not tied to any real account or sensitive information.

#### Note:
An app icon and placeholder icon will be added later and absense doesn't affect project's functionality.



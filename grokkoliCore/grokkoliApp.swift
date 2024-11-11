import SwiftData
import SwiftUI
import Combine

@main
struct grokkoliApp: App {
    @StateObject private var appState = AppState() 
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
                .modelContainer(for: GlucoseReading.self)
                .accentColor(.accent) 
        }
    }
}

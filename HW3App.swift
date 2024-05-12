import SwiftUI
import Firebase

@main
struct HW3App: App {
    @StateObject var nightModeManager = NightModeManager()

    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(nightModeManager) // Inject NightModeManager as environment object

        }
    }
}


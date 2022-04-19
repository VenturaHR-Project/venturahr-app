import SwiftUI

@main
struct VenturaHRApp: App {
    private let firebaseService: FirebaseServiceProtocol = FirebaseService()
    
    init() {
        firebaseService.configureFirebaseApp()
    }
    
    var body: some Scene {
        WindowGroup {
            SplashViewRouter.start()
        }
    }
}

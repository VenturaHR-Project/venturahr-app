import Firebase
import Combine

protocol FirebaseServiceProtocol {
    var auth: Auth { get }
    func configureFirebaseApp()
}

final class FirebaseService {
    init() {}
}

extension FirebaseService: FirebaseServiceProtocol {
    var auth: Auth {
        Auth.auth()
    }
    
    func configureFirebaseApp() {
        FirebaseApp.configure()
    }
}

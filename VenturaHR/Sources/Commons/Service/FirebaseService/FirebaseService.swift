import Firebase

protocol FirebaseServiceProtocol {
    var auth: Auth { get }
    func configureFirebaseApp()
    func getCurrentUser() -> User?
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
    
    func getCurrentUser() -> User? {
        guard let currentUser = auth.currentUser else { return nil }
        return currentUser
    }
}

import Firebase

protocol FirebaseServiceProtocol {
    var auth: Auth { get }
    var firestore: Firestore { get }
    func configureFirebaseApp()
    func getCurrentUser() -> User?
}

final class FirebaseService {
    init() {}
}

extension FirebaseService: FirebaseServiceProtocol {
    var firestore: Firestore {
        Firestore.firestore()
    }
    
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

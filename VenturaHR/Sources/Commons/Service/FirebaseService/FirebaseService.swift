import Firebase

protocol FirebaseServiceProtocol {
    var auth: Auth { get }
    func configureFirebaseApp()
    func getUID() -> String?
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
    
    func getUID() -> String? {
        guard let uid = auth.currentUser?.uid else { return nil }
        return uid
    }
    
    func getCurrentUser() -> User? {
        guard let currentUser = auth.currentUser else { return nil }
        return currentUser
    }
}

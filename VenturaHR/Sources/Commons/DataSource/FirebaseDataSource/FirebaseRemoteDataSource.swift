import Combine

protocol FirebaseRemoteDataSourceProtocol {
    func getUid() -> String?
    func hasCurrentUser() -> Bool
    func createUserWith(email: String, password: String) -> Future<Bool, NetworkError>
    func deleteUser()
    func signIn(email: String, password: String) -> Future<Bool, Error>
    func signOut() -> Future<Bool, NetworkError>
}

final class FirebaseRemoteDataSource {
    private let firebaseService: FirebaseServiceProtocol
    
    init(
        firebaseService: FirebaseServiceProtocol = FirebaseService()
    ) {
        self.firebaseService = firebaseService
    }
}

extension FirebaseRemoteDataSource: FirebaseRemoteDataSourceProtocol {
    func getUid() -> String? {
        guard let uid = firebaseService.auth.currentUser?.uid else { return nil }
        return uid
    }
    
    func hasCurrentUser() -> Bool {
        if firebaseService.auth.currentUser == nil {
            return false
        }
        
        return true
    }
    
    func createUserWith(email: String, password: String) -> Future<Bool, NetworkError> {
        return Future { promise in
            self.firebaseService.auth.createUser(
                withEmail: email,
                password: password
            ) { result, error in
                if let error = error {
                    promise(.failure(.detail(error.localizedDescription)))
                    return
                }
                
                promise(.success(true))
            }
        }
    }
    
    func deleteUser() {
        firebaseService.auth.currentUser?.delete()
    }
    
    func signIn(email: String, password: String) -> Future<Bool, Error> {
        return Future { promise in
            self.firebaseService.auth.signIn(withEmail: email, password: password) { result, error in
                if let error = error {
                    promise(.failure(error))
                    return
                }
                
                promise(.success(true))
            }
        }
    }
    
    func signOut() -> Future<Bool, NetworkError> {
        return Future { promise in
            do {
                try self.firebaseService.auth.signOut()
                promise(.success(true))
            } catch let signOutError {
                promise(.failure(.detail(signOutError.localizedDescription)))
            }
        }
    }
}

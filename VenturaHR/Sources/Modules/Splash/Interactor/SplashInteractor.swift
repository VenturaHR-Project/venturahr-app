import Combine

protocol SplashInteractorProtocol {
    func hasCurrentUser() -> Bool
    func handleGetUserUid() -> String?
    func fetchUser(by uid: String) -> Future<GenericUser, NetworkError>
    func saveUserAccountLocally(data: GenericUser)
}

final class SplashInteractor {
    private let firebaseRemoteDataSource: FirebaseRemoteDataSourceProtocol
    private let userRemoteDataSource: UserRemoteDataSourceProtocol
    private let userLocalDataSource: UserLocalDataSourceProtocol
    
    init(
        firebaseRemoteDataSource: FirebaseRemoteDataSourceProtocol = FirebaseRemoteDataSource(),
        userRemoteDataSource: UserRemoteDataSourceProtocol = UserRemoteDataSource(),
        userLocalDataSource: UserLocalDataSourceProtocol = UserLocalDataSource()
    ) {
        self.firebaseRemoteDataSource = firebaseRemoteDataSource
        self.userRemoteDataSource = userRemoteDataSource
        self.userLocalDataSource = userLocalDataSource
    }
}

extension SplashInteractor: SplashInteractorProtocol {
    func hasCurrentUser() -> Bool {
        return firebaseRemoteDataSource.hasCurrentUser()
    }
    
    func handleGetUserUid() -> String? {
        return firebaseRemoteDataSource.getUid()
    }
    
    func fetchUser(by uid: String) -> Future<GenericUser, NetworkError> {
        return userRemoteDataSource.fetchUser(by: uid)
    }
    
    func saveUserAccountLocally(data: GenericUser) {
        userLocalDataSource.saveAccountLocally(data: data)
    }
}

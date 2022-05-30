import Combine

protocol SignInInteractorProtocol {
    func handleGetUserUid() -> String?
    func handleSignIn(request: SignInRequest) -> Future<Bool, Error>
    func handleSignOut() -> Future<Bool, NetworkError>
    func fetchUser(by uid: String) -> Future<GenericUser, NetworkError>
    func saveUserAccountLocally(data: GenericUser)
}

final class SignInInteractor {
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

extension SignInInteractor: SignInInteractorProtocol {
    func handleGetUserUid() -> String? {
        return firebaseRemoteDataSource.getUid()
    }
    
    func handleSignIn(request: SignInRequest) -> Future<Bool, Error> {
        return firebaseRemoteDataSource.signIn(email: request.email, password: request.password)
    }
    
    func handleSignOut() -> Future<Bool, NetworkError> {
        return firebaseRemoteDataSource.signOut()
    }
    
    func fetchUser(by uid: String) -> Future<GenericUser, NetworkError> {
        return userRemoteDataSource.fetchUser(by: uid)
    }
    
    func saveUserAccountLocally(data: GenericUser) {
        userLocalDataSource.saveAccountLocally(data: data)
    }
}

import Combine

protocol SignUpInteractorProtocol {
    func handleGetUserUid() -> String?
    func saveUserInFirebaseAuth(email: String, password: String) -> Future<Bool, NetworkError>
    func saveUserInMicroservice(request: SignUpRequest) -> Future<Bool, NetworkError>
    func saveUserAccountTypeLocally(value: String)
    func deleteFirabaseAuthUser()
}

final class SignUpInteractor {
    private let firebaseRemoteDataSource: FirebaseRemoteDataSourceProtocol
    private let signUpremoteDataSource: SignUpRemoteDataSourceProtocol
    private let userLocalDataSource: UserLocalDataSourceProtocol
    
    init(
        firebaseRemoteDataSource: FirebaseRemoteDataSourceProtocol = FirebaseRemoteDataSource(),
        signUpremoteDataSource: SignUpRemoteDataSourceProtocol = SignUpRemoteDataSource(),
        userLocalDataSource: UserLocalDataSourceProtocol = UserLocalDataSource()
    ) {
        self.firebaseRemoteDataSource = firebaseRemoteDataSource
        self.signUpremoteDataSource = signUpremoteDataSource
        self.userLocalDataSource = userLocalDataSource
    }
}

extension SignUpInteractor: SignUpInteractorProtocol {
    func handleGetUserUid() -> String? {
        return firebaseRemoteDataSource.getUid()
    }
    
    func saveUserInFirebaseAuth(email: String, password: String) -> Future<Bool, NetworkError> {
        return firebaseRemoteDataSource.createUserWith(email: email, password: password)
    }
    
    func saveUserInMicroservice(request: SignUpRequest) -> Future<Bool, NetworkError> {
        return signUpremoteDataSource.saveUserInMicroservice(request: request)
    }
    
    func saveUserAccountTypeLocally(value: String) {
        userLocalDataSource.saveAccountType(value: value)
    }
    
    func deleteFirabaseAuthUser() {
        firebaseRemoteDataSource.deleteUser()
    }
}

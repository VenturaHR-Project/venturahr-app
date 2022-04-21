import Combine

protocol SignInRemoteDataSourceProtocol {
    func signIn(request: SignInRequest) -> Future<Bool, Error>
}

final class SignInRemoteDataSource {
    private var firebaseService: FirebaseServiceProtocol
    
    init(firebaseService: FirebaseServiceProtocol = FirebaseService()) {
        self.firebaseService = firebaseService
    }
}

extension SignInRemoteDataSource: SignInRemoteDataSourceProtocol {
    func signIn(request: SignInRequest) -> Future<Bool, Error> {
        return Future { promise in
            self.firebaseService.auth.signIn(
                withEmail: request.email,
                password: request.password
            ) { result, error in
                if let error = error {
                    promise(.failure(error))
                    return
                }
                
                promise(.success(true))
            }
        }
    }
}

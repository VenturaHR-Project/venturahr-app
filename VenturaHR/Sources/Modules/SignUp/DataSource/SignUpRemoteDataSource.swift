import Combine

protocol SignUpRemoteDataSourceProtocol {
    func createUser(request: SignUpRequest) -> Future<Bool, NetworkError>
}

final class SignUpRemoteDataSource {
    private var firebaseService: FirebaseServiceProtocol
    private var userMicroservice: UserMicroserviceProtocol
    
    init(
        firebaseService: FirebaseServiceProtocol = FirebaseService(),
        userMicroservice: UserMicroserviceProtocol = UserMicroservice()
    ) {
        self.firebaseService = firebaseService
        self.userMicroservice = userMicroservice
    }
}

extension SignUpRemoteDataSource: SignUpRemoteDataSourceProtocol {
    func createUser(request: SignUpRequest) -> Future<Bool, NetworkError> {
        return Future { promise in
            self.firebaseService.auth.createUser(
                withEmail: request.email,
                password: request.password
            ) { result, error in
                if let error = error {
                    promise(.failure(.detail(error.localizedDescription)))
                    return
                }
                
                self.userMicroservice.saveUser(request: request) { result in
                    switch result {
                    case let .failure(networkError, _):
                        self.firebaseService.auth.currentUser?.delete()
                        promise(.failure(networkError))
                    case .success(_):
                        promise(.success(true))
                    }
                }
            }
        }
    }
}

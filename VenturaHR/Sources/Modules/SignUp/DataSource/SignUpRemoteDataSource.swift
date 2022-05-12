import Combine

protocol SignUpRemoteDataSourceProtocol {
    func saveUserInMicroservice(request: SignUpRequest) -> Future<Bool, NetworkError>
}

final class SignUpRemoteDataSource {
    private var userMicroservice: UserMicroserviceProtocol
    
    init(
        userMicroservice: UserMicroserviceProtocol = UserMicroservice()
    ) {
        self.userMicroservice = userMicroservice
    }
}

extension SignUpRemoteDataSource: SignUpRemoteDataSourceProtocol {
    func saveUserInMicroservice(request: SignUpRequest) -> Future<Bool, NetworkError> {
        return Future { promise in
            self.userMicroservice.saveUser(request: request) { result in
                switch result {
                case let .failure(networkError, _):
                    promise(.failure(networkError))
                case .success(_):
                    promise(.success(true))
                }
            }
        }
    }
}


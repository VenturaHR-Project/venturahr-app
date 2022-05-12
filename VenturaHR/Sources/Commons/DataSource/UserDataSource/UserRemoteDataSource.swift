import Combine

protocol UserRemoteDataSourceProtocol {
    func fetchUser(by uid: String) -> Future<GenericUser, NetworkError>
}

final class UserRemoteDataSource {
    private let userMicroservice: UserMicroserviceProtocol
    
    init(
        userMicroservice: UserMicroserviceProtocol = UserMicroservice()
    ) {
        self.userMicroservice = userMicroservice
    }
}

extension UserRemoteDataSource: UserRemoteDataSourceProtocol {
    func fetchUser(by uid: String) -> Future<GenericUser, NetworkError> {
        return Future { promise in
            self.userMicroservice.getUser(uid: uid) { result in
                switch result {
                case let .failure(networkError, _):
                    promise(.failure(networkError))
                case let .success(data):
                    
                    guard let genericUser = GenericUser.decode(data: data) else {
                        promise(.failure(.decodeFailure("An unexpected error occurred")))
                        return
                    }
                    
                    promise(.success(genericUser))
                }
            }
        }
    }
}

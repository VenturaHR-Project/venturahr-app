import Combine

protocol SignUpRemoteDataSourceProtocol {
    func createUser(request: SignUpRequest) -> Future<Bool, Error>
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
    func createUser(request: SignUpRequest) -> Future<Bool, Error> {
        return Future { promise in
            self.firebaseService.auth.createUser(
                withEmail: request.email,
                password: request.password
            ) { result, error in
                if let error = error {
                    promise(.failure(error))
                    return
                }
                
                self.userMicroservice.saveUser(user: request) { result in
                    switch result {
                    case .failure(let httpError):
                        self.firebaseService.auth.currentUser?.delete()
                        promise(.failure(httpError))
                        break
                    case .success(let created):
                        promise(.success(created))
                        break
                    }
                }
            }
        }
    }
}

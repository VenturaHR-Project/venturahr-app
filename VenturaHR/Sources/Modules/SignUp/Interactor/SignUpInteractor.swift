import Combine

protocol SignUpInteractorProtocol {
    func handleSignUp(request: SignUpRequest) -> Future<Bool, Error>
}

final class SignUpInteractor {
    private let signUpRemoteDataSource: SignUpRemoteDataSourceProtocol
    
    init(signUpRemoteDataSource: SignUpRemoteDataSourceProtocol = SignUpRemoteDataSource()) {
        self.signUpRemoteDataSource = signUpRemoteDataSource
    }
}

extension SignUpInteractor: SignUpInteractorProtocol {
    func handleSignUp(request: SignUpRequest) -> Future<Bool, Error> {
        return signUpRemoteDataSource.createUser(request: request)
    }
}

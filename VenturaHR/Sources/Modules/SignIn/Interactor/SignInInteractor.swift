import Combine

protocol SignInInteractorProtocol {
    func handleSignIn(request: SignInRequest) -> Future<Bool, Error>
}

final class SignInInteractor {
    private let signInRemoteDataSource: SignInRemoteDataSourceProtocol
    
    init(signInRemoteDataSource: SignInRemoteDataSourceProtocol = SignInRemoteDataSource()) {
        self.signInRemoteDataSource = signInRemoteDataSource
    }
}

extension SignInInteractor: SignInInteractorProtocol {
    func handleSignIn(request: SignInRequest) -> Future<Bool, Error> {
        return signInRemoteDataSource.signIn(request: request)
    }
}

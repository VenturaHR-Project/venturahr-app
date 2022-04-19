import Combine

protocol SignUpRemoteDataSourceProtocol {
    func createUser(request: SignUpRequest) -> Future <Bool, Error>
}

final class SignUpRemoteDataSource {
    
}

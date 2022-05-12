import Foundation

protocol UserMicroserviceProtocol {
    func saveUser(request: SignUpRequest, completion: @escaping (NetworkResult) -> Void)
    func getUser(uid: String, completion: @escaping (NetworkResult) -> Void)
}

final class UserMicroservice {
    private var network: NetworkProtocol
    
    init(
        network: NetworkProtocol = Network.shared
    ) {
        self.network = network
    }
    
    private func buildUser(user: SignUpRequest) -> GenericUser {
        switch user.accountType {
        case .candidate:
            let candidate = GenericUserFactory.create(
                uid: user.uid,
                name: user.name,
                email: user.email,
                password: user.password,
                accountType: user.accountType.rawValue,
                phone: user.phone,
                address: user.address,
                cpf: user.cpf
            )
            return candidate
        case .company:
            let company = GenericUserFactory.create(
                uid: user.uid,
                name: user.name,
                email: user.email, password: user.password,
                accountType: user.accountType.rawValue,
                phone: user.phone,
                address: user.address,
                cnpj: user.cnpj,
                corporateName: user.corporateName
            )
            return company
        }
    }
}

extension UserMicroservice: UserMicroserviceProtocol {
    func saveUser(request: SignUpRequest, completion: @escaping (NetworkResult) -> Void) {
        let user = buildUser(user: request)
        let path = UserMicroserviceEndpoint.postUser.value
        
        network.call(path: path, method: .post, body: user) { result in
            switch result {
            case let .failure(httpError, data):
                completion(.failure(httpError, data))
                break
            case let .success(data):
                completion(.success(data))
            }
        }
    }
    
    func getUser(uid: String, completion: @escaping (NetworkResult) -> Void) {
        let path = String(format: UserMicroserviceEndpoint.getUserByUID.value, uid)
        
        network.call(path: path, method: .get) { result in
            switch result {
            case let .failure(httpError, data):
                completion(.failure(httpError, data))
                break
            case let .success(data):
                completion(.success(data))
            }
        }
    }
}

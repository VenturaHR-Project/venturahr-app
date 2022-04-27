import Foundation
import Combine

protocol UserMicroserviceProtocol {
    func saveUser(request: SignUpRequest, completion: @escaping (NetworkResult) -> Void)
    func getUser(completion: @escaping (NetworkResult) -> Void)
}

final class UserMicroservice {
    private var firebaseService: FirebaseServiceProtocol
    private var network: NetworkProtocol
    
    init(
        firebaseService: FirebaseServiceProtocol = FirebaseService(),
        network: NetworkProtocol = Network.shared
    ) {
        self.firebaseService = firebaseService
        self.network = network
    }
    
    private func buildUser(user: SignUpRequest, uid: String) -> GenericUser {
        switch user.accountType {
        case .candidate:
            let candidate = GenericUserFactory.create(
                uid: uid,
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
                uid: uid,
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
        guard let uid = firebaseService.getUID() else { return }
        
        let user = buildUser(user: request, uid: uid)
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
    
    func getUser(completion: @escaping (NetworkResult) -> Void) {
        guard let uid = firebaseService.getUID() else { return }
        let path = String(format: UserMicroserviceEndpoint.postUser.value, uid)
        
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

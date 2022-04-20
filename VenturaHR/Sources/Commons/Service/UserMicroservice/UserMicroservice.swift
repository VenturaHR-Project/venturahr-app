protocol UserMicroserviceProtocol {
    func saveUser(user: SignUpRequest, callback: @escaping BoolCallback)
}

final class UserMicroservice {}

extension UserMicroservice: UserMicroserviceProtocol {
    func saveUser(user: SignUpRequest, callback: @escaping BoolCallback) {
        switch user.accountType {
        case .candidate:
            let candidate = CandidateFactory.create(
                uid: user.name,
                name: user.name,
                email: user.email, password: user.password,
                accountType: user.accountType.rawValue,
                phone: user.phone,
                address: user.address,
                cpf: user.cpf
            )
            
            Network.call(path: .postUser, method: .post, body: candidate) { result in
                switch result {
                case .failure(let httpError):
                    callback(.failure(httpError))
                case .success(let createdUser):
                    callback(.success(createdUser))
                }
            }
            break
        case .company:
            let company = CompanyFactory.create(
                uid: user.name,
                name: user.name,
                email: user.email, password: user.password,
                accountType: user.accountType.rawValue,
                phone: user.phone,
                address: user.address,
                cnpj: user.cnpj,
                corporateName: user.corporateName
            )
            
            Network.call(path: .postUser, method: .post, body: company) { result in
                switch result {
                case .failure(let httpError):
                    callback(.failure(httpError))
                case .success(let createdUser):
                    callback(.success(createdUser))
                }
            }
            break
        }
    }
}

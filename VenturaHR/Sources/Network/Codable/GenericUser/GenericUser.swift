struct GenericUser {
    var uid: String
    var name: String
    var email: String
    var password: String
    var accountType: String
    var phone: String
    var address: String
    var cpf: String?
    var cnpj: String?
    var corporateName: String?
}

extension GenericUser: Codable {
    enum CodingKeys: String, CodingKey {
        case uid
        case name
        case email
        case password
        case accountType
        case phone
        case address
        case cpf
        case cnpj
        case corporateName
    }
}

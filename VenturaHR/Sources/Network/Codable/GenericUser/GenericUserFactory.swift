struct GenericUserFactory {
    static func create(
        uid: String,
        name: String,
        email: String,
        password: String,
        accountType: String,
        phone: String,
        address: String,
        cpf: String
    ) -> GenericUser {
        return GenericUser(
            uid: uid,
            name: name,
            email: email,
            password: password,
            accountType: accountType,
            phone: phone,
            address: address,
            cpf: cpf
        )
    }
    
    static func create(
        uid: String,
        name: String,
        email: String,
        password: String,
        accountType: String,
        phone: String,
        address: String,
        cnpj: String,
        corporateName: String
    ) -> GenericUser {
        return GenericUser(
            uid: uid,
            name: name,
            email: email,
            password: password,
            accountType: accountType,
            phone: phone,
            address: address,
            cnpj: cnpj,
            corporateName: corporateName
        )
    }
}

final class User {
    var name: String
    var email: String
    var password: String
    var phone: String
    var address: String
    var accountType: AccountType
    var cpf: String
    var cnpj: String
    var corporateName: String
    
    init(
        name: String = "",
        email: String = "",
        password: String = "",
        phone: String = "",
        address: String = "",
        accountType: AccountType = .candidate,
        cpf: String = "",
        cnpj: String =  "",
        corporateName: String = ""
    ) {
        self.name = name
        self.email = email
        self.password = password
        self.phone = phone
        self.address = address
        self.accountType = accountType
        self.cpf = cpf
        self.cnpj = cnpj
        self.corporateName = corporateName
    }
}

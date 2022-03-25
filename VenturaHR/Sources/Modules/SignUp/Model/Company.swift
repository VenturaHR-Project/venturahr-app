class Company: User {
    private var cnpj: String
    private var corporateName: String
    
    init(name: String,
         email: String,
         password: String,
         phone: String,
         address: String,
         accountType: AccountType = .candidate,
         cnpj: String,
         corporateName: String
    ) {
        self.cnpj = cnpj
        self.corporateName = corporateName
        super.init(name: name, email: email, password: password, phone: phone, address: address)
    }
}

class Candidate: User {
    private var cpf: String
    
    init(name: String,
         email: String,
         password: String,
         phone: String,
         address: String,
         accountType: AccountType = .candidate,
         cpf: String
    ) {
        self.cpf = cpf
        super.init(name: name, email: email, password: password, phone: phone, address: address)
    }
}

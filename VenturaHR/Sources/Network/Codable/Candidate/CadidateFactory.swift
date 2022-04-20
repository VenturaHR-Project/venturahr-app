final class CandidateFactory {
    static func create(
        uid: String,
        name: String,
        email: String,
        password: String,
        accountType: String,
        phone: String,
        address: String,
        cpf: String
    ) -> Candidate {
        return Candidate(
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
}

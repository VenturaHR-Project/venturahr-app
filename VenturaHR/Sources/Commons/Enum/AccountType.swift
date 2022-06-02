enum AccountType: String, CaseIterable {
    case candidate = "Candidato"
    case company = "Empresa"
    
    var isCandidate: Bool {
        return self == .candidate
    }
    
    var isCompany: Bool {
        return self == .company
    }
}

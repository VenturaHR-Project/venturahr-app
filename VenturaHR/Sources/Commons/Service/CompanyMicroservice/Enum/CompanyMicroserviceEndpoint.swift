enum CompanyMicroserviceEndpoint {
    case postVacancy
    case getVacancies
    case getVacanciesByCompany
}

extension CompanyMicroserviceEndpoint {
    private var baseUrl: String {
        "http://localhost:3001"
    }
    
    var value: String {
        switch self {
        case .postVacancy:
            return "\(baseUrl)/companys"
        case .getVacancies:
            return "\(baseUrl)/companys"
        case .getVacanciesByCompany:
            return "\(baseUrl)/companys/%@"
        }
    }
}

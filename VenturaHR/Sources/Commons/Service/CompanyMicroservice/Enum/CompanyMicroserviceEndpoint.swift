enum CompanyMicroserviceEndpoint {
    case postVacancy
    case getVacancyByCompany
}

extension CompanyMicroserviceEndpoint {
    private var baseUrl: String {
        "http://localhost:3001"
    }
    
    var value: String {
        switch self {
        case .postVacancy:
            return "\(baseUrl)/companys"
        case .getVacancyByCompany:
            return "\(baseUrl)/companys/%@"
        }
    }
}

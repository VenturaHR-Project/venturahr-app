enum CandidateMicroserviceEndpoint {
    case postAnswerVacancy
    case getAnswersByVacancyId
}

extension CandidateMicroserviceEndpoint {
    private var baseUrl: String {
        "http://localhost:3002"
    }
    
    var value: String {
        switch self {
        case .postAnswerVacancy:
            return "\(baseUrl)/answers"
        case .getAnswersByVacancyId:
            return "\(baseUrl)/answers/%@"
        }
    }
}


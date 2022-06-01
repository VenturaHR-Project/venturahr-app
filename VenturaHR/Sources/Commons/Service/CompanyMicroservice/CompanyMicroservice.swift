protocol CompanyMicroserviceProtocol {
    func saveVacancy(request: VacancyRequest, completion: @escaping (NetworkResult) -> Void)
    func getVacanciesByCompany(name: String, completion: @escaping (NetworkResult) -> Void)
}

final class CompanyMicroservice {
    private var network: NetworkProtocol
    
    init(network: NetworkProtocol = Network.shared) {
        self.network = network
    }
    
    private func buildVacancy(request: VacancyRequest) -> Vacancy {
        let skills = Skill.map(expectedSkills: request.expectedSkills)
        
        let vacancy = Vacancy(uid: request.uid,
                              ocupation: request.ocupation,
                              description: request.description,
                              company: request.company,
                              state: request.state,
                              city: request.city,
                              jobType: request.jobType.rawValue,
                              hiringPeriod: request.hiringPeriod.rawValue,
                              expectedSkills: skills,
                              createdAt: request.createdAt,
                              expiresAt: request.expiresAt)
        
        return vacancy
    }
}

extension CompanyMicroservice: CompanyMicroserviceProtocol {
    func saveVacancy(request: VacancyRequest, completion: @escaping (NetworkResult) -> Void) {
        let path = CompanyMicroserviceEndpoint.postVacancy.value
        let vacancy = buildVacancy(request: request)
        
        network.call(path: path, method: .post, body: vacancy) { result in
            switch result {
            case let .failure(httpError, data):
                completion(.failure(httpError, data))
                break
            case let .success(data):
                completion(.success(data))
            }
        }
    }
    
    func getVacanciesByCompany(name: String, completion: @escaping (NetworkResult) -> Void) {
        let path = String(format: CompanyMicroserviceEndpoint.getVacancyByCompany.value, name)
        
        network.call(path: path, method: .get) { result in
            switch result {
            case let .failure(httpError, data):
                completion(.failure(httpError, data))
                break
            case let .success(data):
                completion(.success(data))
            }
        }
    }
}

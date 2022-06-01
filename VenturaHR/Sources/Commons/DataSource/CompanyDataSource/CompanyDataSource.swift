import Combine

protocol CompanyRemoteDataSourceProtocol {
    func saveVacancy(request: VacancyRequest) -> Future<Bool, NetworkError>
    func getVacanciesByCompany(name: String) -> Future<[Vacancy], NetworkError>
}

final class CompanyRemoteDataSource {
    private let companyMicroservice: CompanyMicroserviceProtocol
    
    init(companyMicroservice: CompanyMicroserviceProtocol = CompanyMicroservice()) {
        self.companyMicroservice = companyMicroservice
    }
}

extension CompanyRemoteDataSource: CompanyRemoteDataSourceProtocol {
    func saveVacancy(request: VacancyRequest) -> Future<Bool, NetworkError> {
        return Future { promise in
            self.companyMicroservice.saveVacancy(request: request) { result in
                switch result {
                case let .failure(networkError, _):
                    promise(.failure(networkError))
                case .success(_):
                    promise(.success(true))
                }
            }
        }
    }
    
    func getVacanciesByCompany(name: String) -> Future<[Vacancy], NetworkError> {
        return Future { promise in
            self.companyMicroservice.getVacanciesByCompany(name: name) { result in
                switch result {
                case let .failure(networkError, _):
                    promise(.failure(networkError))
                case let .success(data):
                    guard let vacancies = Vacancy.decode(data: data) else {
                        promise(.failure(.decodeFailure("An unexpected error occurred")))
                        return
                    }
                    
                    promise(.success(vacancies))
                }
            }
        }
    }
}

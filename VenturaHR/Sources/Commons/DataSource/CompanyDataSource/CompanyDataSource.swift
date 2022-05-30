import Combine

protocol CompanyRemoteDataSourceProtocol {
    func saveVacancy(request: VacancyRequest) -> Future<Bool, NetworkError>
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
}

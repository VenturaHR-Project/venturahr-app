import Combine

protocol VacanciesInteractorProtocol {
    func handleGetUserName() -> String?
    func handleGetAccountType() -> String?
    func handleGetVacancies() -> Future<[Vacancy], NetworkError>
    func handleGetVacanciesByCompany(name: String) -> Future<[Vacancy], NetworkError>
}

final class VacanciesInteractor {
    private let ibgeRemoteDataSource: IbgeRemoteDataSourceProtocol
    private let companyRemoteDataSource: CompanyRemoteDataSourceProtocol
    private let userLocalDataSource: UserLocalDataSourceProtocol
    
    init(
        ibgeRemoteDataSource: IbgeRemoteDataSourceProtocol = IbgeRemoteDataSource(),
        companyRemoteDataSource: CompanyRemoteDataSourceProtocol = CompanyRemoteDataSource(),
        userLocalDataSource: UserLocalDataSourceProtocol = UserLocalDataSource()
        
    ) {
        self.ibgeRemoteDataSource = ibgeRemoteDataSource
        self.companyRemoteDataSource = companyRemoteDataSource
        self.userLocalDataSource = userLocalDataSource
    }
}

extension VacanciesInteractor: VacanciesInteractorProtocol {
    func handleGetUserName() -> String? {
        return userLocalDataSource.getUserName()
    }
    
    func handleGetAccountType() -> String? {
        return userLocalDataSource.getAccountType()
    }
    
    func handleGetVacancies() -> Future<[Vacancy], NetworkError> {
        return companyRemoteDataSource.getVacancies()
    }
    
    func handleGetVacanciesByCompany(name: String) -> Future<[Vacancy], NetworkError> {
        return companyRemoteDataSource.getVacanciesByCompany(name: name)
    }
}

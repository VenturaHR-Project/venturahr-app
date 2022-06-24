import Combine

protocol VacanciesInteractorProtocol {
    func handleGetUserUid() -> String?
    func handleGetUserPhone() -> String?
    func handleGetUserName() -> String?
    func handleGetAccountType() -> String?
    func handleGetVacancies() -> Future<[Vacancy], NetworkError>
    func handleGetVacanciesByCompany(name: String) -> Future<[Vacancy], NetworkError>
}

final class VacanciesInteractor {
    private let ibgeRemoteDataSource: IbgeRemoteDataSourceProtocol
    private let companyRemoteDataSource: CompanyRemoteDataSourceProtocol
    private let userLocalDataSource: UserLocalDataSourceProtocol
    private let firebaseRemoteDataSource: FirebaseRemoteDataSourceProtocol
    
    init(
        ibgeRemoteDataSource: IbgeRemoteDataSourceProtocol = IbgeRemoteDataSource(),
        companyRemoteDataSource: CompanyRemoteDataSourceProtocol = CompanyRemoteDataSource(),
        userLocalDataSource: UserLocalDataSourceProtocol = UserLocalDataSource(),
        firebaseRemoteDataSource: FirebaseRemoteDataSourceProtocol = FirebaseRemoteDataSource()
        
    ) {
        self.ibgeRemoteDataSource = ibgeRemoteDataSource
        self.companyRemoteDataSource = companyRemoteDataSource
        self.userLocalDataSource = userLocalDataSource
        self.firebaseRemoteDataSource = firebaseRemoteDataSource
    }
}

extension VacanciesInteractor: VacanciesInteractorProtocol {
    func handleGetUserUid() -> String? {
        return userLocalDataSource.getUserUid()
    }
    
    func handleGetUserPhone() -> String? {
        return userLocalDataSource.getUserPhone()
    }
    
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

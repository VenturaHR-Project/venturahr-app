import Combine

protocol VacancyInteractorProtocol {
    func handleGetUserUid() -> String?
    func handleGetUserName() -> String?
    func saveVacancy(request: VacancyRequest) -> Future<Bool, NetworkError>
    func getStates() -> Future<[IbgeState], NetworkError>
    func getCities(uf: String) -> Future<[IbgeCity], NetworkError>
}

final class VacancyInteractor {
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

extension VacancyInteractor: VacancyInteractorProtocol {
    func handleGetUserUid() -> String? {
        return userLocalDataSource.getUserUid()
    }
    
    func handleGetUserName() -> String? {
        return userLocalDataSource.getUserName()
    }
    
    func saveVacancy(request: VacancyRequest) -> Future<Bool, NetworkError> {
        return companyRemoteDataSource.saveVacancy(request: request)
    }
    
    func getStates() -> Future<[IbgeState], NetworkError> {
        return ibgeRemoteDataSource.getStates()
    }
    
    func getCities(uf: String) -> Future<[IbgeCity], NetworkError> {
        return ibgeRemoteDataSource.getCities(uf: uf)
    }
}

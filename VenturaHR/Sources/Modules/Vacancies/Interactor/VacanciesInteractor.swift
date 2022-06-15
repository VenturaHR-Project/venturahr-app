import Combine

protocol VacanciesInteractorProtocol {
    func handleGetUserUid() -> String?
    func handleGetUserName() -> String?
    func handleGetAccountType() -> String?
    func handleGetVacancies() -> Future<[Vacancy], NetworkError>
    func handleGetVacanciesByCompany(name: String) -> Future<[Vacancy], NetworkError>
    func handleApplyForVacancy(vacancy: Vacancy) -> Future<Bool, NetworkError>
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
    func handleApplyForVacancy(vacancy: Vacancy) -> Future<Bool, NetworkError> {
        return firebaseRemoteDataSource.addFirestoreItem(collection: "answers",
                                                         documentName: vacancy.uid,
                                                         data: vacancy)
    }
    
    func handleGetUserUid() -> String? {
        return userLocalDataSource.getUserUid()
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

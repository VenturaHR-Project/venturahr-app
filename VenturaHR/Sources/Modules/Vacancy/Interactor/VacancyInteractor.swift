import Combine

protocol VacancyInteractorProtocol {
    func getStates() -> Future<[IbgeState], NetworkError>
    func getCities(uf: String) -> Future<[IbgeCity], NetworkError>
    
}

final class VacancyInteractor {
    private let ibgeRemoteDataSource: IbgeRemoteDataSourceProtocol
    
    init(
        ibgeRemoteDataSource: IbgeRemoteDataSourceProtocol = IbgeRemoteDataSource()
    ) {
        self.ibgeRemoteDataSource = ibgeRemoteDataSource
    }
}

extension VacancyInteractor: VacancyInteractorProtocol {
    func getStates() -> Future<[IbgeState], NetworkError> {
        return ibgeRemoteDataSource.getStates()
    }
    
    func getCities(uf: String) -> Future<[IbgeCity], NetworkError> {
        return ibgeRemoteDataSource.getCities(uf: uf)
    }
}

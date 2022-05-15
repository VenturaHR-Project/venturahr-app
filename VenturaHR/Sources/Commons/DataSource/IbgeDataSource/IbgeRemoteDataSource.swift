import Combine

protocol IbgeRemoteDataSourceProtocol {
    func getStates() -> Future<[IbgeState], NetworkError>
    func getCities(uf: String) -> Future<[IbgeCity], NetworkError>
}

final class IbgeRemoteDataSource {
    private let ibgeService: IbgeServiceProtocol
    
    init(ibgeService: IbgeServiceProtocol = IbgeService()) {
        self.ibgeService = ibgeService
    }
}

extension IbgeRemoteDataSource: IbgeRemoteDataSourceProtocol {
    func getStates() -> Future<[IbgeState], NetworkError> {
        return Future { promise in
            self.ibgeService.getUfs { resut in
                switch resut {
                case let .failure(networkError, _):
                    promise(.failure(networkError))
                case let .success(data):
                    guard let states = IbgeState.decode(data: data) else {
                        promise(.failure(.decodeFailure("An unexpected error occurred")))
                        return
                    }
                    
                    promise(.success(states))
                }
            }
        }
    }
    
    func getCities(uf: String) -> Future<[IbgeCity], NetworkError> {
        return Future { promise in
            self.ibgeService.getCities(uf: uf) { result in
                switch result {
                case let .failure(networkError, _):
                    promise(.failure(networkError))
                case let .success(data):
                    guard let cities = IbgeCity.decode(data: data) else {
                        promise(.failure(.decodeFailure("An unexpected error occurred")))
                        return
                    }
                    
                    promise(.success(cities))
                }
            }
        }
    }
}

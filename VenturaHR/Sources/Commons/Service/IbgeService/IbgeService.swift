import Foundation

protocol IbgeServiceProtocol {
    func getUfs(completion: @escaping (NetworkResult) -> Void)
    func getCities(uf: String,completion: @escaping (NetworkResult) -> Void)
}

final class IbgeService {
    private var network: NetworkProtocol
    
    init(network: NetworkProtocol = Network.shared) {
        self.network = network
    }
}

extension IbgeService: IbgeServiceProtocol {
    func getUfs(completion: @escaping (NetworkResult) -> Void) {
        let path = IbgeServiceEndpoint.getUfs.value

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
    
    func getCities(uf: String, completion: @escaping (NetworkResult) -> Void) {
        let path = String(format: IbgeServiceEndpoint.getCities.value, uf)
        
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

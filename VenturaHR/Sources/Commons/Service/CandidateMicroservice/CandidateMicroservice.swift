protocol CandidateMicroserviceProtocol {
    func saveAnswerVacancy(request: AnswerVacancyDTO, completion: @escaping (NetworkResult) -> Void)
    func fetchAnswersByVacancyId(with vacancyId: String, completion: @escaping (NetworkResult) -> Void)
}

final class CandidateMicroservice {
    private var network: NetworkProtocol
    
    init(network: NetworkProtocol = Network.shared) {
        self.network = network
    }
}

extension CandidateMicroservice: CandidateMicroserviceProtocol {
    func saveAnswerVacancy(request: AnswerVacancyDTO, completion: @escaping (NetworkResult) -> Void) {
        let path = CandidateMicroserviceEndpoint.postAnswerVacancy.value
        
        network.call(path: path, method: .post, body: request) { result in
            switch result {
            case let .failure(httpError, data):
                completion(.failure(httpError, data))
                break
            case let .success(data):
                completion(.success(data))
                break
            }
        }
    }
    
    func fetchAnswersByVacancyId(with vacancyId: String, completion: @escaping (NetworkResult) -> Void) {
        let path = CandidateMicroserviceEndpoint.getAnswersByVacancyId.value
        let formatedPath = String(format: path, vacancyId)
        
        network.call(path: formatedPath, method: .get) { result in
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

import Combine

protocol CandidateRemoteDataSourceProtocol {
    func saveAnswerVacancy(request: AnswerVacancyDTO) -> Future<Bool, NetworkError>
}

final class CandidateRemoteDataSource {
    private let candidateMicroservice: CandidateMicroserviceProtocol
    
    init(candidateMicroservice: CandidateMicroserviceProtocol = CandidateMicroservice()) {
        self.candidateMicroservice = candidateMicroservice
    }
}

extension CandidateRemoteDataSource: CandidateRemoteDataSourceProtocol {
    func saveAnswerVacancy(request: AnswerVacancyDTO) -> Future<Bool, NetworkError> {
        return Future { promise in
            self.candidateMicroservice.saveAnswerVacancy(request: request) { result in
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

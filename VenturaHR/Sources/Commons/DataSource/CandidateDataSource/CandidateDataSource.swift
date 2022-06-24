import Combine

protocol CandidateRemoteDataSourceProtocol {
    func saveAnswerVacancy(request: AnswerVacancyDTO) -> Future<Bool, NetworkError>
    func fetchAnswersByVacancyId(with vacancyId: String) -> Future<[AnswerVacancyResponseDTO], NetworkError>
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
    
    func fetchAnswersByVacancyId(with vacancyId: String) -> Future<[AnswerVacancyResponseDTO], NetworkError> {
        return Future { promise in
            self.candidateMicroservice.fetchAnswersByVacancyId(with: vacancyId) { result in
                switch result {
                case let .failure(networkError, _):
                    promise(.failure(networkError))
                case let .success(data):
                    guard let answers = AnswerVacancyResponseDTO.decode(data: data) else {
                        promise(.failure(.decodeFailure("An unexpected error occurred")))
                        return
                    }
                    
                    promise(.success(answers))
                }
            }
        }
    }
}

import Combine

protocol AnswerVacancyInteractorProtocol {
    func handleApplyForVacancy(answer: AnswerVacancyDTO) -> Future<Bool, NetworkError>
}

final class AnswerVacancyInteractor {
    private let candidateRemoteDataSource: CandidateRemoteDataSourceProtocol
    
    init(
        candidateRemoteDataSource: CandidateRemoteDataSourceProtocol = CandidateRemoteDataSource()
    ) {
        self.candidateRemoteDataSource = candidateRemoteDataSource
    }
}

extension AnswerVacancyInteractor: AnswerVacancyInteractorProtocol {
    func handleApplyForVacancy(answer: AnswerVacancyDTO) -> Future<Bool, NetworkError> {
        return candidateRemoteDataSource.saveAnswerVacancy(request: answer)
    }
}

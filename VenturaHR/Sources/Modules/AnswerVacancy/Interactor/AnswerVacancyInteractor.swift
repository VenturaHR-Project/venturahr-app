import Combine

protocol AnswerVacancyInteractorProtocol {
    func handleApplyForVacancy(answer: AnswerVacancyDTO) -> Future<Bool, NetworkError>
    func handleGetUserPhone() -> String?
    func handleGetUserName() -> String?
}

final class AnswerVacancyInteractor {
    private let candidateRemoteDataSource: CandidateRemoteDataSourceProtocol
    private let userLocalDataSource: UserLocalDataSourceProtocol
    
    init(
        candidateRemoteDataSource: CandidateRemoteDataSourceProtocol = CandidateRemoteDataSource(),
        userLocalDataSource: UserLocalDataSourceProtocol = UserLocalDataSource()
    ) {
        self.candidateRemoteDataSource = candidateRemoteDataSource
        self.userLocalDataSource = userLocalDataSource
    }
}

extension AnswerVacancyInteractor: AnswerVacancyInteractorProtocol {
    func handleApplyForVacancy(answer: AnswerVacancyDTO) -> Future<Bool, NetworkError> {
        return candidateRemoteDataSource.saveAnswerVacancy(request: answer)
    }
    
    func handleGetUserPhone() -> String? {
        return userLocalDataSource.getUserPhone()
    }
    
    func handleGetUserName() -> String? {
        return userLocalDataSource.getUserName()
    }
}

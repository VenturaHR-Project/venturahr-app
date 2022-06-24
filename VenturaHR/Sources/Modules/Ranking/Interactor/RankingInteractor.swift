import Combine

protocol RankingInteractorProtocol {
    func handleFetchAnswersByVacancyId(with vacancyId: String) -> Future<[AnswerVacancyResponseDTO], NetworkError>
    func fetchUser(by uid: String) -> Future<GenericUser, NetworkError>
}

final class RankingInteractor {
    private let candidateRemoteDataSource: CandidateRemoteDataSourceProtocol
    private let userRemoteDataSource: UserRemoteDataSourceProtocol
    
    init(candidateRemoteDataSource: CandidateRemoteDataSourceProtocol = CandidateRemoteDataSource(),
         userRemoteDataSource: UserRemoteDataSourceProtocol = UserRemoteDataSource()
    ) {
        self.candidateRemoteDataSource = candidateRemoteDataSource
        self.userRemoteDataSource = userRemoteDataSource
    }
}

extension RankingInteractor: RankingInteractorProtocol {
    func handleFetchAnswersByVacancyId(with vacancyId: String) -> Future<[AnswerVacancyResponseDTO], NetworkError> {
        return candidateRemoteDataSource.fetchAnswersByVacancyId(with: vacancyId)
    }
    
    func fetchUser(by uid: String) -> Future<GenericUser, NetworkError> {
        return userRemoteDataSource.fetchUser(by: uid)
    }
}

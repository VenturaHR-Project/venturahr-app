import Combine

protocol AnswerVacancyInteractorProtocol {
    func handleApplyForVacancy(answer: AnswerVacancyDTO) -> Future<Bool, NetworkError>
}

final class AnswerVacancyInteractor {
    private let firebaseRemoteDataSource: FirebaseRemoteDataSourceProtocol
    
    init(
        firebaseRemoteDataSource: FirebaseRemoteDataSourceProtocol = FirebaseRemoteDataSource()
    ) {
        self.firebaseRemoteDataSource = firebaseRemoteDataSource
    }
}

extension AnswerVacancyInteractor: AnswerVacancyInteractorProtocol {
    func handleApplyForVacancy(answer: AnswerVacancyDTO) -> Future<Bool, NetworkError> {
        return firebaseRemoteDataSource.addFirestoreItem(collection: "answers",
                                                         documentName: answer.userUid,
                                                         data: answer)
    }
}

import Foundation
import Combine

final class RankingViewModel: ObservableObject {
    @Published var uiState: UIState = .none
    @Published var candidateData: [CandidateData] = []
    
    private let interactor: RankingInteractor
    private var cancellables: Set<AnyCancellable>
    
    var vacancyId: String
    
    init(
        vacancyId: String,
        interactor: RankingInteractor = RankingInteractor(),
        cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    ) {
        self.vacancyId = vacancyId
        self.interactor = interactor
        self.cancellables = cancellables
    }
    
    deinit {
        cancellCancellables()
    }
    
    private func cancellCancellables() {
        for cancellable in cancellables {
            cancellable.cancel()
        }
    }
    
    func fetchCandidateRanking() {
        interactor.handleFetchAnswersByVacancyId(with: vacancyId)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case let .failure(networkError):
                    self.uiState = .error(networkError.localizedDescription)
                case .finished: break
                }
            } receiveValue: { answers in
                let mappedCandidate: [CandidateData] = CandidateData.map(answersResponse: answers)
                print(mappedCandidate)
            }
            .store(in: &cancellables)
    }
}

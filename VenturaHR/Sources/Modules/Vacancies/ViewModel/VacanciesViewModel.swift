import Combine
import SwiftUI

class VacanciesViewModel: ObservableObject {
    @Published private(set) var uiState: VacanciesUIState = .loading
    @Published private(set) var accountType: AccountType = .candidate
    @Published private(set) var vacancies: [VacancyViewData] = []
    
    private var cancellables: Set<AnyCancellable>
    private let interactor: VacanciesInteractorProtocol
    
    var userUid: String = ""
    var selectedVacacyId: String = ""
    @Published var selectedVacacyExpectedSkills: [ExpectedSkill] = []
    
    init(
        cancellables: Set<AnyCancellable> = Set<AnyCancellable>(),
        interactor: VacanciesInteractorProtocol = VacanciesInteractor()
    ) {
        self.cancellables = cancellables
        self.interactor = interactor
        getUserAccountData()
    }
    
    deinit {
        cancellCancellables()
    }
    
    private func cancellCancellables() {
        for cancellable in cancellables {
            cancellable.cancel()
        }
    }
    
    private func getUserAccountData()  {
        guard
            let type = interactor.handleGetAccountType(),
            let result = AccountType(rawValue: type),
            let uid = interactor.handleGetUserUid()
        else { return }
        
        userUid = uid
        accountType = result
    }
    
    private func handleDefaultCompletion(with completion: Subscribers.Completion<NetworkError>) {
        switch completion {
        case let .failure(networkError):
            uiState = .hasError(message: networkError.localizedDescription)
            break
        case .finished:
            break
        }
    }
    
    private func handleReceiveValue(data: [Vacancy]) {
        vacancies = VacancyViewData.map(vacancies: data)
        uiState = .fullList
    }
    
    private func getVacanciesByCompany() {
        guard let name = interactor.handleGetUserName() else { return }
        interactor.handleGetVacanciesByCompany(name: name)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                self.handleDefaultCompletion(with: completion)
            } receiveValue: { vacancies in
                self.handleReceiveValue(data: vacancies)
            }
            .store(in: &cancellables)
    }
    
    private func getVacancies() {
        interactor.handleGetVacancies()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                self.handleDefaultCompletion(with: completion)
            } receiveValue: { vacancies in
                self.handleReceiveValue(data: vacancies)
            }
            .store(in: &cancellables)
    }

    func fetchVacancies() {
        uiState = .loading
        accountType.isCandidate ? getVacancies() : getVacanciesByCompany()
    }
}

extension VacanciesViewModel {
    func goToVacancyCreateView() -> some View {
        return VacanciesViewRouter.makeVacancyCreateView()
    }
    
    func goToAnswerVacancyView(userUid: String, vacancyId: String, expectedSkills: [ExpectedSkill]) -> some View {
        return VacanciesViewRouter.makeAnswerVacancyView(userUid: userUid, vacancyId: vacancyId, expectedSkills: expectedSkills)
    }
    
    func goToRankingView(vacancyId: String) -> some View {
        return VacanciesViewRouter.makeRankingView(vacancyId: vacancyId)
    }
}

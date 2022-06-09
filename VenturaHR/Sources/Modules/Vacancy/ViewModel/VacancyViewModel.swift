import Combine
import SwiftUI

class VacancyViewModel: ObservableObject {
    @Published private(set) var uiState: VacancyUIState = .loading
    @Published private(set) var accountType: AccountType = .candidate
    @Published private(set) var vacancies: [VacancyViewData] = []
    @Published var shouldPresentVacancyCreateView: Bool = false
    
    private var cancellables: Set<AnyCancellable>
    private let interactor: VacancyInteractorProtocol
    
    init(
        cancellables: Set<AnyCancellable> = Set<AnyCancellable>(),
        interactor: VacancyInteractorProtocol = VacancyInteractor()
    ) {
        self.cancellables = cancellables
        self.interactor = interactor
        getAccountType()
    }
    
    deinit {
        cancellCancellables()
    }
    
    private func cancellCancellables() {
        for cancellable in cancellables {
            cancellable.cancel()
        }
    }
    
    private func getAccountType()  {
        guard
            let type = interactor.handleGetAccountType(),
            let result = AccountType(rawValue: type)
        else { return }
        
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

    func handleOnAppear() {
        uiState = .loading
        accountType.isCandidate ? getVacancies() : getVacanciesByCompany()
    }
    
    func handleSelectAddVacancyButton() {
        shouldPresentVacancyCreateView = true
    }
}

extension VacancyViewModel {
    func goToVacancyCreateView() -> some View {
        return VacancyViewRouter.makeVacancyCreateView()
    }
}

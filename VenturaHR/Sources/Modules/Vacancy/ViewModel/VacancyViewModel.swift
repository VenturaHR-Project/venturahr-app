import Combine
import SwiftUI

class VacancyViewModel: ObservableObject {
    @Published private(set) var uiState: VacancyUIState = .loading
    @Published private(set) var updatedVacancies: Bool = false
    @Published private(set) var accountType: AccountType = .company
    @Published private(set) var vacancies: [VacancyViewData] = []
    @Published var shouldPresentVacancyCreateView: Bool = false
    
    private var cancellables: Set<AnyCancellable>
    private let vacancyCreatePublisher: PassthroughSubject<Bool, Never>
    private let interactor: VacancyInteractorProtocol
    
    init(
        cancellables: Set<AnyCancellable> = Set<AnyCancellable>(),
        vacancyCreatePublisher: PassthroughSubject<Bool, Never> = PassthroughSubject<Bool, Never>(),
        interactor: VacancyInteractorProtocol = VacancyInteractor()
    ) {
        self.cancellables = cancellables
        self.vacancyCreatePublisher = vacancyCreatePublisher
        self.interactor = interactor
        observeVacancyCreate()
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
    
    private func observeVacancyCreate() {
        vacancyCreatePublisher.sink { _ in
            self.updatedVacancies = false
            self.handleOnAppear()
        }
        .store(in: &cancellables)
    }
    
    private func getAccountType()  {
        guard
            let type = interactor.handleGetAccountType(),
            let result = AccountType(rawValue: type)
        else { return }
        
        accountType = result
    }

    func handleOnAppear() {
        uiState = .loading
        
        if updatedVacancies {
            self.uiState = .fullList
            return
        }
        
        updatedVacancies = true
        guard let name = interactor.handleGetUserName() else { return }
        interactor.handleGetVacanciesByCompany(name: name)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.uiState = .hasError(message: error.localizedDescription)
                case .finished: break
                }
            } receiveValue: { vacancies in
                self.vacancies = VacancyViewData.map(vacancies: vacancies)
                self.uiState = .fullList
            }
            .store(in: &cancellables)
    }
    
    func handleSelectAddVacancyButton() {
        shouldPresentVacancyCreateView = true
    }
}

extension VacancyViewModel {
    func goToVacancyCreateView() -> some View {
        return VacancyViewRouter.makeVacancyCreateView(publisher: vacancyCreatePublisher)
    }
}

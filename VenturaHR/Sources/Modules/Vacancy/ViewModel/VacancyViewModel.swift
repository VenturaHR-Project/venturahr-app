import Combine
import Foundation

class VacancyViewModel: ObservableObject {
    @Published private(set) var uiState: VacancyUIState = .loading
    @Published private(set) var opened: Bool = false
    @Published private(set) var accountType: AccountType = .candidate
    @Published private(set) var vacancies: [VacancyViewData] = []
    
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
            self.handleOnAppear()
        }
        .store(in: &cancellables)
    }

    func handleOnAppear() {
        uiState = .loading
        
        if opened {
            self.uiState = .fullList
            return
        }
        
        opened = true
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
}

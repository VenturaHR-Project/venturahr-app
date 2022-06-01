import Combine
import Foundation

class VacancyViewModel: ObservableObject {
    @Published var uiState: VacancyUIState = .fullList
    @Published var isOpened: Bool = false
    
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
        guard let name = interactor.handleGetUserName() else { return }
        
        uiState = .loading
        isOpened = true
        
        interactor.handleGetVacanciesByCompany(name: name)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.uiState = .hasError(message: error.localizedDescription)
                case .finished: break
                }
            } receiveValue: { vacancies in
                let teste = vacancies
                print(teste)
            }
            .store(in: &cancellables)
    }
}

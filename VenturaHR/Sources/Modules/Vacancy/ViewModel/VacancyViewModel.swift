import Combine
import Foundation

final class VacancyViewModel: ObservableObject {
    @Published var vacancyRequest = VacancyRequest()
    @Published var ibgeStates: [IbgeState] = []
    @Published var ibgeCities: [IbgeCity] = []
    
    private var cancellables: Set<AnyCancellable>
    private var interactor: VacancyInteractorProtocol
    
    init(
        cancellables: Set<AnyCancellable> = Set<AnyCancellable>(),
        interactor: VacancyInteractorProtocol = VacancyInteractor()
    ) {
        self.cancellables = cancellables
        self.interactor = interactor
    }
    
    deinit {
        cancellCancellables()
    }
    
    var shouldDisableCitySelector: Bool {
        vacancyRequest.state.isEmpty
    }
    
    private func cancellCancellables() {
        for cancellable in cancellables {
            cancellable.cancel()
        }
    }
    
    private func handleDefaultCompletion(with completion: Subscribers.Completion<NetworkError>) {
        switch completion {
        case .failure(_):
            break
        case .finished:
            break
        }
    }
    
    private func clearCitySelector() {
        vacancyRequest.city = ""
    }
    private func fetchCities() {
        interactor.getCities(uf: vacancyRequest.state)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                self.handleDefaultCompletion(with: completion)
            } receiveValue: { cities in
                self.ibgeCities = cities
            }
            .store(in: &cancellables)
    }
    
    func fetchStates() {
        interactor.getStates()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                self.handleDefaultCompletion(with: completion)
            } receiveValue: { states in
                self.ibgeStates = states
            }
            .store(in: &cancellables)
    }
    
    func handleChageSelectedState() {
        clearCitySelector()
        fetchCities()
    }
}

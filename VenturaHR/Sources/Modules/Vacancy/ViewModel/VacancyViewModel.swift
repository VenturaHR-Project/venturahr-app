import Combine
import Foundation

final class VacancyViewModel: ObservableObject {
    @Published var vacancy = Vacancy()
    @Published var expectedSkill = ExpectedSkill()
    @Published var expectedSkills: [ExpectedSkill] = []
    @Published var ibgeStates: [IbgeState] = []
    @Published var ibgeCities: [IbgeCity] = []
    @Published var showCitySelectorProgress: Bool = true
    @Published var shouldPresentExpectedSkiilsSheet = false
    
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
        vacancy.state.isEmpty
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
        vacancy.city = ""
    }
    
    private func fetchCities() {
        interactor.getCities(uf: vacancy.state)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                self.handleDefaultCompletion(with: completion)
            } receiveValue: { cities in
                self.ibgeCities = cities
                self.showCitySelectorProgress = false
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
    
    func showExpectedSkillsSheet() {
        shouldPresentExpectedSkiilsSheet = true
    }
    
    func handleSaveVacancy() {
        print("ffdsfds")
    }
}

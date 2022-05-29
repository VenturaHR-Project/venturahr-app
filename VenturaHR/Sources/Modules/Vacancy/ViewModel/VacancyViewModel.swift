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
    @Published var createdDate = Date()
    @Published var expiresDate = Date()
    
    private var cancellables: Set<AnyCancellable>
    private var interactor: VacancyInteractorProtocol
    
    var shouldDisableCitySelector: Bool {
        vacancy.state.isEmpty
    }
    
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
        vacancy.city = ""
        fetchCities()
    }
    
    func showExpectedSkillsSheet() {
        shouldPresentExpectedSkiilsSheet = true
    }
    
    func getNextMonth() -> Date {
        guard let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: Date()) else { return Date() }
        return nextMonth
    }
    
    func handleSelectDeleteSkill(skill: ExpectedSkill) {
        expectedSkills.removeAll {
            $0 == skill
        }
    }
    
    func handleSaveVacancy() {
        print("ffdsfds")
    }
}

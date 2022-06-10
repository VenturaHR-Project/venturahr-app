import Combine
import Foundation

final class VacancyCreateViewModel: ObservableObject {
    @Published var uiState: UIState = .none
    @Published var vacancy = VacancyRequest()
    @Published var expectedSkill = ExpectedSkill()
    @Published var expectedSkills: [ExpectedSkill] = []
    @Published var ibgeStates: [IbgeState] = []
    @Published var ibgeCities: [IbgeCity] = []
    @Published var createdDate = Date()
    @Published var expiresDate = Date()
    @Published var showCitySelectorProgress: Bool = true
    @Published var shouldPresentExpectedSkiilsSheet: Bool = false
    @Published var shouldPresentPopup : Bool = false
    

    private let interactor: VacancyCreateInteractorProtocol
    private var cancellables: Set<AnyCancellable>
    
    var shouldDisableCitySelector: Bool {
        vacancy.state.isEmpty
    }
    
    init(
        cancellables: Set<AnyCancellable> = Set<AnyCancellable>(),
        interactor: VacancyCreateInteractorProtocol = VacancyCreateInteractor()
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
        case let .failure(networkError):
            uiState = .error(networkError.localizedDescription)
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
    
    private func setUserValues() {
        guard
            let uid = interactor.handleGetUserUid(),
            let name = interactor.handleGetUserName()
        else { return }
        
        vacancy.uid = uid
        vacancy.company = name
    }
    
    private func setDatesFormatted() {
        let dateHelper = DateHelper()
        let createdDateFormatted = dateHelper.parseDateToString(value: createdDate)
        let expiresDateFormatted = dateHelper.parseDateToString(value: expiresDate)
    
        vacancy.createdAt = createdDateFormatted
        vacancy.expiresAt = expiresDateFormatted
    }
    
    private func clearFormFields() {
        vacancy.ocupation = ""
        vacancy.description = ""
        vacancy.state = ""
        vacancy.city = ""
        createdDate = Date()
        expiresDate = Date()
        expectedSkills = []
        expectedSkill.description = ""
        expectedSkill.desiredMinimumProfile = .veryLow
        expectedSkill.height = 1
    }
    
    func handleOnAppear() {
        setUserValues()
        fetchStates()
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
        guard let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: createdDate) else { return Date() }
        return nextMonth
    }
    
    func handleSelectDeleteSkill(skill: ExpectedSkill) {
        expectedSkills.removeAll {
            $0 == skill
        }
    }
    
    func handleSaveVacancy() {
        setDatesFormatted()
        
        vacancy.expectedSkills = expectedSkills
        interactor.saveVacancy(request: vacancy)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                self.handleDefaultCompletion(with: completion)
            } receiveValue: { created in
                self.clearFormFields()
                self.uiState = .success
                self.shouldPresentPopup = true
            }
            .store(in: &cancellables)
    }
}

extension VacancyCreateViewModel {
    var isSaveButtonDisabled: Bool {
        vacancy.ocupation.isEmpty ||
        vacancy.description.isEmpty ||
        vacancy.company.isEmpty ||
        vacancy.state.isEmpty ||
        vacancy.city.isEmpty ||
        expectedSkills.isEmpty
    }
}

import Combine
import Foundation

final class AnswerVacancyViewModel: ObservableObject {
    @Published var uiState: UIState = .none
    @Published var showCitySelectorProgress: Bool = true
    @Published var shouldPresentPopup : Bool = false
    @Published var savedAnswer: Bool = false
    @Published var expectedSkills: [ExpectedSkill] = []
    
    private let interactor: AnswerVacancyInteractorProtocol
    private var cancellables: Set<AnyCancellable>
    private var userUid: String = ""
    private var vacancyId: String = ""
    
    init(
        cancellables: Set<AnyCancellable> = Set<AnyCancellable>(),
        interactor: AnswerVacancyInteractorProtocol = AnswerVacancyInteractor()
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
    
    private func calculateAnswersScore() -> Double {
        var leftValue: Double = 0
        var rightValue: Double = 0
        var multipliedValues: Double = 0
        var result: Double = 0
        
        expectedSkills.forEach { skill in
            let answerProfile = Double(skill.desiredMinimumProfile.value)
            let skillWeight = Double(skill.height)
            
            multipliedValues = answerProfile * skillWeight
            leftValue += multipliedValues
            rightValue += skillWeight
        }
        result = leftValue / rightValue
        return result
    }
    
    func handleOnAppear(userUid: String, vacancyId: String, requiredSkills: [ExpectedSkill]) {
        expectedSkills = requiredSkills
        self.userUid = userUid
        self.vacancyId = vacancyId
    }
    
    func showExpectedSkillName(skillId: String) -> String {
        let skill = expectedSkills.first { $0.id == skillId }
        guard let skillName = skill?.description else { return "" }
        return skillName
    }
    
    func handleAnswerVacancy() {
        guard let userName = interactor.handleGetUserName() else { return }
        guard let userPhone = interactor.handleGetUserPhone() else { return }
        let createdDateFormatted = DateHelper().parseDateToString(value: Date())
        let mappedAnswers = Answer.map(expectedSkills: expectedSkills)
        let answer: AnswerVacancyDTO = AnswerVacancyDTO(userUid: userUid,
                                                        vacancyId: vacancyId,
                                                        userName: userName,
                                                        userPhone: userPhone,
                                                        answers: mappedAnswers,
                                                        createdDate: createdDateFormatted)
        
        interactor.handleApplyForVacancy(answer: answer)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                self.handleDefaultCompletion(with: completion)
            } receiveValue: { created in
                self.shouldPresentPopup = true
            }
            .store(in: &cancellables)
    }
}

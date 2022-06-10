import Foundation

final class MainViewModel: ObservableObject {
    @Published private(set) var accountType: AccountType = .candidate
    
    private let interactor: VacanciesInteractorProtocol
    
    init(interactor: VacanciesInteractorProtocol = VacanciesInteractor()) {
        self.interactor = interactor
        getAccountType()
    }
    
    private func getAccountType()  {
        guard
            let type = interactor.handleGetAccountType(),
            let result = AccountType(rawValue: type)
        else { return }
        
        accountType = result
    }
}

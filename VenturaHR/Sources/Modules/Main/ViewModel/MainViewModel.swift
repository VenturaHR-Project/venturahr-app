import Foundation

final class MainViewModel: ObservableObject {
    private let interactor: MainInteractorProtocol
    
    init(
        interactor: MainInteractorProtocol = MainInteractor()
    ) {
        self.interactor = interactor
        if let teste = interactor.handleGetAccountType() {
            print(teste)
        }
    }
}

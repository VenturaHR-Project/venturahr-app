import Combine
import Foundation

final class SignInViewModel: ObservableObject {
    @Published var signInRequest = SignInRequest()
    @Published var uiState: SignInUIState = .none
    
    private var cancellable: AnyCancellable?
    private let interactor: SignInInteractorProtocol
    
    init(interactor: SignInInteractorProtocol = SignInInteractor()) {
        self.interactor = interactor
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func handleSignIn() {
        uiState = .loading
        
        cancellable = interactor.handleSignIn(request: signInRequest)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.uiState = .error(error.localizedDescription)
                case .finished: break
                }
            }, receiveValue: { logged in
                self.uiState = .goToMainScreen
            })
    }
}

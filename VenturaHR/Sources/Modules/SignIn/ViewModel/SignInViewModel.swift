import Combine
import SwiftUI

final class SignInViewModel: ObservableObject {
    @Published var signInRequest = SignInRequest()
    @Published var uiState: UIState = .none
    
    private var cancellableSignUp: AnyCancellable?
    private var cancellableSignIn: AnyCancellable?
    private var publisher = PassthroughSubject<Bool, Never>()
    
    private let interactor: SignInInteractorProtocol
    
    init(interactor: SignInInteractorProtocol = SignInInteractor()) {
        self.interactor = interactor
        observeSignUp()
    }
    
    deinit {
        cancellableSignIn?.cancel()
        cancellableSignUp?.cancel()
    }
    
    private func observeSignUp() {
        cancellableSignUp = publisher.sink { value in
            if value {
                self.uiState = .success
            }
        }
    }
    
    func handleSignIn() {
        uiState = .loading
        
        cancellableSignIn = interactor.handleSignIn(request: signInRequest)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.uiState = .error(error.localizedDescription)
                case .finished: break
                }
            }, receiveValue: { logged in
                self.uiState = .success
            })
    }
}

extension SignInViewModel {
    func goToSignUpView() -> some View {
        return SignInViewRouter.makeSignUpView(publisher: publisher)
    }
    
    func goToMainView() -> some View {
        return SignInViewRouter.makeHomeView()
    }
}

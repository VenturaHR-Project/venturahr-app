import Combine
import SwiftUI

final class SignInViewModel: ObservableObject {
    @Published var signInRequest = SignInRequest()
    @Published var uiState: UIState = .none
    
    private var cancellables = Set<AnyCancellable>()
    private let publisher = PassthroughSubject<Bool, Never>()
    private let interactor: SignInInteractorProtocol
    
    
    init(
        interactor: SignInInteractorProtocol = SignInInteractor()
    ) {
        self.interactor = interactor
        observeSignUp()
    }
    
    deinit {
        cancellCancellables()
    }
    
    private func observeSignUp() {
        publisher.sink { value in
            if value {
                self.uiState = .success
            }
        }
        .store(in: &cancellables)
    }
    
    private func cancellCancellables() {
        for cancellable in cancellables {
            cancellable.cancel()
        }
    }
    
    private func handleSaveUserAccountType() {
        guard let uid = interactor.handleGetUserUid() else { return }

        interactor.fetchUser(by: uid)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.uiState = .error("Internal server error: volte novamente mais tarde")
                case .finished: break
                }
            }, receiveValue: { genericUser in
                self.interactor.saveUserAccountLocally(data: genericUser)
            })
            .store(in: &cancellables)
    }
    
    func handleSignIn() {
        uiState = .loading
        
        interactor.handleSignIn(request: signInRequest)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.uiState = .error(error.localizedDescription)
                case .finished: break
                }
            }, receiveValue: { logged in
                self.handleSaveUserAccountType()
                self.uiState = .success
            })
            .store(in: &cancellables)
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

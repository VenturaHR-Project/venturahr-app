import Combine
import SwiftUI

final class SplashViewModel: ObservableObject {
    @Published var uiState: SplashUIState = .loading
    
    private var cancellable: AnyCancellable?
    private let interactor: SplashInteractorProtocol
    
    init(
        interactor: SplashInteractorProtocol = SplashInteractor()
    ) {
        self.interactor = interactor as! SplashInteractor
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func handleOnAppear() {
        if !interactor.hasCurrentUser() {
            self.uiState = .goToSignInScreen
            return
        }
        guard let uid = interactor.handleGetUserUid() else { return }
        
        cancellable = interactor.fetchUser(by: uid)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.uiState = .goToSignInScreen
                case .finished: break
                }
            }, receiveValue: { genericUser in
                self.interactor.saveUserAccountLocally(data: genericUser)
                self.uiState = .goToSignInScreen
            })
    }
}

extension SplashViewModel {
    func goToSignInView() -> some View {
        return SplashViewRouter.makeSignInView()
    }
    
    func goToMainView() -> some View {
        return SplashViewRouter.makeMainView()
    }
}

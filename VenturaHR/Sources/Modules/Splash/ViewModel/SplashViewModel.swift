import Combine
import SwiftUI

final class SplashViewModel: ObservableObject {
    @Published var uiState: SplashUIState = .loading
    
    private var fireabaseService: FirebaseServiceProtocol
    
    init(fireabaseService: FirebaseServiceProtocol = FirebaseService()) {
        self.fireabaseService = fireabaseService
    }
    
    func handleOnAppear() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            if self.fireabaseService.getCurrentUser() == nil {
                self.uiState = .goToSignInScreen
                return
            }
            
            self.uiState = .goToSignInScreen
        }
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

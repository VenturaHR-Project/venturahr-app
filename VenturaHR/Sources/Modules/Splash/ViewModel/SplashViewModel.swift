import Combine
import SwiftUI

final class SplashViewModel: ObservableObject {
    @Published var uiState: SplashUIState = .loading
    
    func handleOnAppear() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.uiState = .goToLandingScreen
        }
    }
}

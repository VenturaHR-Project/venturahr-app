import Combine

final class SignInViewModel: ObservableObject {
    @Published var userSignIn = UserSignIn()
    @Published var uiState: UIState = .none
    
    func handleSignIn() {}
}

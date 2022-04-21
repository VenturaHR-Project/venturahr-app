enum SignInUIState: Equatable {
    case none
    case loading
    case goToMainScreen
    case error(String)
}

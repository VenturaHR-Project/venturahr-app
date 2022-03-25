import Combine

final class SignUpViewModel: ObservableObject {
    @Published var user = User()
    @Published var uiState: UIState = .none
    
    var isButtonDisabled: Bool {
        var isDisabled = false
        let areCommonUserFieldsEmpty = (
            user.name.isEmpty || user.email.isEmpty || user.password.isEmpty || user.phone.isEmpty || user.address.isEmpty
        )
        
        switch user.accountType {
        case .candidate:
            isDisabled = areCommonUserFieldsEmpty || user.cpf.isEmpty
        case .company:
            isDisabled = areCommonUserFieldsEmpty || user.cnpj.isEmpty || user.corporateName.isEmpty
        }
        return isDisabled
    }
    
    func handleSignUp() {
        uiState = .loading
        // TODO: Implement SignUp method
    }
}

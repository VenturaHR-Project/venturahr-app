import Combine

final class SignUpViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var phone: String = ""
    @Published var address: String = ""
    @Published var accountType: AccountType = .candidate
    @Published var uiState: UIState = .none
    
    var hasValidNameField: Bool {
        FormValidator.hasMinLenght(value: name, min: 3)
    }
    
    var hasValidEmailFiled: Bool {
        FormValidator.isEmailValid(value: email)
    }
    
    var hasValidPasswordField: Bool {
        FormValidator.hasMinLenght(value: password, min: 6)
    }
    
    var hasValidPhoneField: Bool {
        let hasMinLenght = FormValidator.hasMinLenght(value: phone, min: 14)
        let hasMaxLenght = FormValidator.hasMinLenght(value: phone, min: 15)
        let hasFailure = hasMinLenght || hasMaxLenght
        return hasFailure
    }
    
    var isButtonDisabled: Bool {
        hasValidNameField || hasValidEmailFiled || hasValidPasswordField || hasValidPhoneField
    }
    
    func handleSignUp() {
        uiState = .loading
    }
}

import Combine
import Foundation

final class SignUpViewModel: ObservableObject {
    @Published var signUpRequest = SignUpRequest()
    @Published var uiState: UIState = .none
    
    func handleSignUp() {
        uiState = .loading
        // TODO: Implement SignUp method
    }
}

extension SignUpViewModel {
    func isEmail() -> Bool {
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        return NSPredicate(format:"SELF MATCHES %@", regEx).evaluate(with: signUpRequest.email)
    }
    
    func hasMinLenght(value: String, min: Int) -> Bool {
        return value.count < min
    }
    
    var isButtonDisabled: Bool {
        var isDisabled = false
        let areCommonUserFieldsEmpty = (
            signUpRequest.name.isEmpty
            || signUpRequest.email.isEmpty
            || signUpRequest.password.isEmpty
            || signUpRequest.phone.isEmpty
            || signUpRequest.address.isEmpty
        )
        
        switch signUpRequest.accountType {
        case .candidate:
            isDisabled = areCommonUserFieldsEmpty || signUpRequest.cpf.isEmpty
        case .company:
            isDisabled = areCommonUserFieldsEmpty || signUpRequest.cnpj.isEmpty || signUpRequest.corporateName.isEmpty
        }
        return isDisabled
    }
}

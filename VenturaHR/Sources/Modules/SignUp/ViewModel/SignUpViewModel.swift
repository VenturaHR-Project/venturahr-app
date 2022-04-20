import Combine
import Foundation

final class SignUpViewModel: ObservableObject {
    @Published var signUpRequest = SignUpRequest()
    @Published var uiState: UIState = .none
    
    private var cancellable: AnyCancellable?
    private let interactor: SignUpInteractorProtocol
    
    init(interactor: SignUpInteractorProtocol =  SignUpInteractor()) {
        self.interactor = interactor
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func handleSignUp() {
        uiState = .loading
        
        cancellable = interactor.handleSignUp(request: signUpRequest)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.uiState = .error(error.localizedDescription)
                case .finished:
                    break
                }
            }, receiveValue: { created in
                if created {
                    self.uiState = .success
                }
            })
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

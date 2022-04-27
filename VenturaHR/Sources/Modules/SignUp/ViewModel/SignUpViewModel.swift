import Combine
import Foundation

final class SignUpViewModel: ObservableObject {
    @Published var signUpRequest = SignUpRequest()
    @Published var uiState: UIState = .none
    
    private var cancellableSignUp: AnyCancellable?
    private var publisher: PassthroughSubject<Bool, Never>
    
    private let interactor: SignUpInteractorProtocol
    
    init(
        interactor: SignUpInteractorProtocol = SignUpInteractor(),
        publisher: PassthroughSubject<Bool, Never>
    ) {
        self.interactor = interactor
        self.publisher = publisher
    }
    
    deinit {
        cancellableSignUp?.cancel()
    }
    
    func handleSignUp() {
        uiState = .loading
        
        cancellableSignUp = interactor.handleSignUp(request: signUpRequest)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.uiState = .error(error.description)
                case .finished: break
                }
            }, receiveValue: { created in
                self.publisher.send(created)
                self.uiState = .success
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

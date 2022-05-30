import Combine
import Foundation

final class SignUpViewModel: ObservableObject {
    @Published var signUpRequest = SignUpRequest()
    @Published var uiState: UIState = .none
    
    private var cancellables: Set<AnyCancellable>
    private let publisher: PassthroughSubject<Bool, Never>
    private let interactor: SignUpInteractorProtocol
    
    init(
        cancellables: Set<AnyCancellable> = Set<AnyCancellable>(),
        interactor: SignUpInteractorProtocol = SignUpInteractor(),
        publisher: PassthroughSubject<Bool, Never>
    ) {
        self.cancellables = cancellables
        self.interactor = interactor
        self.publisher = publisher
    }
    
    deinit {
        cancellCancellables()
    }
    
    private func cancellCancellables() {
        for cancellable in cancellables {
            cancellable.cancel()
        }
    }
    
    private func saveUserInMicroservice() {
        guard let uid = interactor.handleGetUserUid() else { return }
        
        signUpRequest.uid = uid
        interactor.saveUserInMicroservice(request: signUpRequest)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.interactor.deleteFirabaseAuthUser()
                    self.uiState = .error(error.description)
                case .finished: break
                }
            } receiveValue: { created in
                let genericUser: GenericUser = GenericUser(uid: self.signUpRequest.uid,
                                                           name: self.signUpRequest.name,
                                                           email: self.signUpRequest.email,
                                                           password: self.signUpRequest.password,
                                                           accountType: self.signUpRequest.accountType.rawValue,
                                                           phone: self.signUpRequest.phone,
                                                           address: self.signUpRequest.address,
                                                           cpf: self.signUpRequest.cpf,
                                                           cnpj: self.signUpRequest.cnpj,
                                                           corporateName: self.signUpRequest.corporateName)
                
                self.interactor.saveUserAccountLocally(data: genericUser)
                self.publisher.send(created)
                self.uiState = .success
            }
            .store(in: &cancellables)
    }
    
    func saveUserInFirebaseAuth() {
        uiState = .loading
        
        interactor.saveUserInFirebaseAuth(email: signUpRequest.email, password: signUpRequest.password)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.uiState = .error(error.description)
                case .finished: break
                }
            }, receiveValue: { created in
                self.saveUserInMicroservice()
            })
            .store(in: &cancellables)
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

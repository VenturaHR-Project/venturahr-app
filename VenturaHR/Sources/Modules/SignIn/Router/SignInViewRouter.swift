import SwiftUI
import Combine

struct SignInViewRouter {
    static func start() -> some View {
        let viewModel = SignInViewModel()
        return SignInView(viewModel: viewModel)
    }
        
    static func makeSignUpView(publisher: PassthroughSubject<Bool, Never>) -> some View {
        SignUpViewRouter.start(publisher: publisher)
    }
    
    static func makeHomeView() -> some View {
        MainViewRouter.start()
    }
}

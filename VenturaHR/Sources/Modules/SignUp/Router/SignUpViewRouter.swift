import SwiftUI
import Combine

struct SignUpViewRouter {
    static func start(publisher: PassthroughSubject<Bool, Never>) -> some View {
        let viewModel = SignUpViewModel(publisher: publisher)
        return SignUpView(viewModel: viewModel)
    }
}

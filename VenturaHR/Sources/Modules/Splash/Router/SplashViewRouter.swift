import SwiftUI

struct SplashViewRouter {
    static func start() -> some View  {
        let viewModel = SplashViewModel()
        return SplashView(viewModel: viewModel)
    }
    
    static func makeSignInView() -> some View {
        SignInViewRouter.start()
    }
    
    static func makeMainView() -> some View {
        MainViewRouter.start()
    }
}

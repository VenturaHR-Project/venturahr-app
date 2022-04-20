import SwiftUI

struct SplashView: View {    
    @StateObject var viewModel: SplashViewModel
    
    var body: some View {
        Group {
            switch viewModel.uiState {
            case .loading:
                loadingView
            case .goToLandingScreen:
                SplashViewRouter.makeSignInView()
            }
        }
        .onAppear(perform: viewModel.handleOnAppear)

    }
    
    private var loadingView: some View {
        ZStack {
            Color.orange
            
            Image(R.image.venturaIcon.name)
                .resizable()
                .scaledToFit()
                .padding(20)
        }
        .ignoresSafeArea()
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            SplashView(viewModel: SplashViewModel())
                .preferredColorScheme($0)
        }
    }
}

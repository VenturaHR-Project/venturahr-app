import SwiftUI

struct SignInView: View {
    @StateObject var viewModel = SignInViewModel()
    
    @State var navigationBarHidden = true
    
    var body: some View {
        ZStack {
            if case SignInUIState.error(let value) = viewModel.uiState {
                Text("")
                    .alert(isPresented: .constant(true)) {
                        Alert(
                            title: Text("VenturaHR"),
                            message: Text(value),
                            dismissButton: .default(Text("Ok"))
                        )
                    }
            }
            
            if case SignInUIState.goToMainScreen = viewModel.uiState {
                SignInViewRouter.makeMainScreen()
            } else {
                NavigationView {
                    ScrollView(showsIndicators: true) {
                        VStack {
                            Spacer(minLength: 50)
                            
                            Text("VenturaHR")
                                .foregroundColor(.orange)
                                .font(.system(.title).bold())
                            
                            Spacer(minLength: 30)
                            
                            emailField
                            
                            passwordField
                            
                            signInButton
                            
                            registerLink
                            
                            Text("Copyright - VenturaHR")
                                .foregroundColor(.gray)
                                .font(Font.system(size: 13).bold())
                                .padding(.top, 16)
                        }
                    }
                    
                    .padding(.horizontal, 32)
                    .navigationTitle("Login")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarHidden(navigationBarHidden)
                }
            }
        }
    }
    
    var emailField: some View {
        InputFieldView(
            viewData: .init(
                text: $viewModel.signInRequest.email,
                placeholder: "Entre com o seu e-mail *",
                keyboard: .emailAddress,
                autocapitalization: .never
            )
        )
    }
    
    var passwordField: some View {
        InputFieldView(
            viewData: .init(
                text: $viewModel.signInRequest.password,
                isSecureField: true,
                placeholder: "Entre com a sua senha *"
            )
        )
    }
    
    var signInButton: some View {
        LoadingButtonView(
            viewData: .init(
                action: viewModel.handleSignIn,
                buttonTitle: "Entrar",
                showProgress: viewModel.uiState == SignInUIState.loading,
                disabled: isSignInButtonDisabled
            )
        )
    }
    
    var registerLink: some View {
        VStack {
            Spacer(minLength: 48)
            
            Text("Ainda não possui conta?")
                .foregroundColor(.gray)
            
            Spacer(minLength: 10)
            
            NavigationLink("Realize seu cadastro", destination: SignUpViewRouter.start)
        }
    }
    
    private var isSignInButtonDisabled: Bool {
        !viewModel.signInRequest.email.isEmail()
        || viewModel.signInRequest.password.hasMinLenght(
            value: viewModel.signInRequest.password, min: 6
        )
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            SignInView()
                .preferredColorScheme($0)
        }
    }
}

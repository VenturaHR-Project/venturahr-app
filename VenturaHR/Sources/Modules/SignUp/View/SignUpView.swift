import SwiftUI

struct SignUpView: View {
    @StateObject var viewModel = SignUpViewModel()
    
    var body: some View {        
        ScrollView(showsIndicators: true) {
            VStack(alignment: .leading) {
                Text("Cadastro")
                    .foregroundColor(Color(R.color.blackWhite.name))
                    .font(.system(.title).bold())
                
                nameField
                
                emailField
                
                passwordField
                
                phoneField
                
                addressField
                
                accountTypeField
                
                saveButton
            }.padding(.horizontal, 8)
        }.padding()
    }
    
    var nameField: some View {
        InputFieldView(viewData: .init(text: $viewModel.name,
                                       placeholder: "Entre com o seu nome *",
                                       keyboard: .alphabet,
                                       hasFailure: viewModel.hasValidNameField,
                                       errorMessage: "Nome precisa ter ao menos 3 caracteres"))
    }
    
    var emailField: some View {
        InputFieldView(viewData: .init(text: $viewModel.email,
                                       placeholder: "Entre com o seu e-mail *",
                                       keyboard: .emailAddress,
                                       hasFailure: viewModel.hasValidEmailFiled,
                                       errorMessage: "E-mail inválido"))
    }
    
    var passwordField: some View {
        InputFieldView(viewData: .init(text: $viewModel.password,
                                       isSecureField: true,
                                       placeholder: "Entre com a sua senha *",
                                       hasFailure: viewModel.hasValidPasswordField,
                                       errorMessage: "Senha precisa ter ao menos 6 caracteres"))
    }
    
    var phoneField: some View {
        InputFieldView(viewData: .init(text: $viewModel.phone,
                                       isSecureField: false,
                                       placeholder: "Entre com o seu celular *",
                                       keyboard: .phonePad,
                                       hasFailure: viewModel.hasValidPhoneField,
                                       errorMessage: "Entre com o DD + 8 ou 9 digitos"))
    }
    
    var addressField: some View {
        InputFieldView(viewData: .init(text: $viewModel.address,
                                       isSecureField: false,
                                       placeholder: "Entre com o seu Endereço *",
                                       keyboard: .alphabet,
                                       hasFailure: false,
                                       errorMessage: "Endereço inválido"))
    }
    
    var accountTypeField: some View {
        Picker("", selection: $viewModel.accountType) {
            ForEach(AccountType.allCases, id: \.self) { type in
                Text(type.rawValue)
                    .tag(type)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.init(top: 16, leading: 0, bottom: 32, trailing: 0))
    }
    
    var saveButton: some View {
        LoadingButtonView(viewData: .init(action: viewModel.handleSignUp,
                                          buttonTitle: "Cadastrar",
                                          showProgress: viewModel.uiState == .loading,
                                          disabled: viewModel.isButtonDisabled))
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            SignUpView()
                .preferredColorScheme($0)
        }
    }
}

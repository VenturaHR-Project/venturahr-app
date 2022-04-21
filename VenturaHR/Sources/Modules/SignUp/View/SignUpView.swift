import SwiftUI

struct SignUpView: View {
    @StateObject var viewModel: SignUpViewModel
    
    var body: some View {
        ZStack {
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
                    
                    if viewModel.signUpRequest.accountType == .candidate {
                        cpfField
                    } else {
                        cnpjField
                        corporateNameField
                    }
                    
                    saveButton
                }.padding(.horizontal, 8)
            }.padding()
            
            if case UIState.error(let value) = viewModel.uiState {
                Text("")
                    .alert(isPresented: .constant(true)) {
                        Alert(
                            title: Text("VenturaHR"), message: Text(value), dismissButton: .default(Text("Ok"))
                        )
                    }
            }
        }
    }
    
    var nameField: some View {
        InputFieldView(
            viewData: .init(
                text: $viewModel.signUpRequest.name,
                placeholder: "Entre com o seu nome *",
                keyboard: .alphabet
            )
        )
    }
    
    var emailField: some View {
        InputFieldView(
            viewData: .init(
                text: $viewModel.signUpRequest.email,
                placeholder: "Entre com o seu e-mail *",
                keyboard: .emailAddress,
                autocapitalization: .never,
                hasFailure: !viewModel.isEmail(),
                errorMessage: "E-mail inválido"
            )
        )
    }
    
    var passwordField: some View {
        InputFieldView(
            viewData: .init(
                text: $viewModel.signUpRequest.password,
                isSecureField: true,
                placeholder: "Entre com a sua senha *",
                hasFailure: viewModel.hasMinLenght(value: viewModel.signUpRequest.password, min: 6),
                errorMessage: "Senha precisa ter ao menos 6 caracteres"
            )
        )
    }
    
    var phoneField: some View {
        InputFieldView(
            viewData: .init(
                text: $viewModel.signUpRequest.phone,
                isSecureField: false,
                placeholder: "Entre com o seu celular *",
                keyboard: .phonePad
            )
        )
    }
    
    var addressField: some View {
        InputFieldView(
            viewData: .init(
                text: $viewModel.signUpRequest.address,
                isSecureField: false,
                placeholder: "Entre com o seu Endereço *",
                keyboard: .alphabet
            )
        )
    }
    
    var accountTypeField: some View {
        Picker("", selection: $viewModel.signUpRequest.accountType) {
            ForEach(AccountType.allCases, id: \.self) { type in
                Text(type.rawValue)
                    .tag(type)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.vertical, 10)
    }
    
    var cpfField: some View {
        InputFieldView(
            viewData: .init(
                text: $viewModel.signUpRequest.cpf,
                isSecureField: false,
                placeholder: "Entre com o seu CPF *",
                keyboard: .alphabet
            )
        )
    }
    
    var cnpjField: some View {
        InputFieldView(
            viewData: .init(
                text: $viewModel.signUpRequest.cnpj,
                isSecureField: false,
                placeholder: "Entre com o seu CNPJ *",
                keyboard: .alphabet
            )
        )
    }
    
    var corporateNameField: some View {
        InputFieldView(
            viewData: .init(
                text: $viewModel.signUpRequest.corporateName,
                isSecureField: false,
                placeholder: "Entre com a razão social *",
                keyboard: .alphabet
            )
        )
    }
    
    var saveButton: some View {
        LoadingButtonView(
            viewData: .init(
                action: viewModel.handleSignUp,
                buttonTitle: "Cadastrar",
                showProgress: viewModel.uiState == .loading,
                disabled: viewModel.isButtonDisabled
            )
        )
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            SignUpView(viewModel: SignUpViewModel(publisher: .init()))
                .preferredColorScheme($0)
        }
    }
}

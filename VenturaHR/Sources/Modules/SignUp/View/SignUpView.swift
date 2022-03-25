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
                
                if viewModel.user.accountType == .candidate {
                    cpfField
                } else {
                    cnpjField
                    corporateNameField
                }
                
                saveButton
            }.padding(.horizontal, 8)
        }.padding()
    }
    
    var nameField: some View {
        InputFieldView(viewData: .init(text: $viewModel.user.name,
                                       placeholder: "Entre com o seu nome *",
                                       keyboard: .alphabet))
    }
    
    var emailField: some View {
        InputFieldView(viewData: .init(text: $viewModel.user.email,
                                       placeholder: "Entre com o seu e-mail *",
                                       keyboard: .emailAddress))
    }
    
    var passwordField: some View {
        InputFieldView(viewData: .init(text: $viewModel.user.password,
                                       isSecureField: true,
                                       placeholder: "Entre com a sua senha *"))
    }
    
    var phoneField: some View {
        InputFieldView(viewData: .init(text: $viewModel.user.phone,
                                       isSecureField: false,
                                       placeholder: "Entre com o seu celular *",
                                       keyboard: .phonePad))
    }
    
    var addressField: some View {
        InputFieldView(viewData: .init(text: $viewModel.user.address,
                                       isSecureField: false,
                                       placeholder: "Entre com o seu Endereço *",
                                       keyboard: .alphabet))
    }
    
    var accountTypeField: some View {
        Picker("", selection: $viewModel.user.accountType) {
            ForEach(AccountType.allCases, id: \.self) { type in
                Text(type.rawValue)
                    .tag(type)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.init(top: 16, leading: 0, bottom: 32, trailing: 0))
    }
    
    var cpfField: some View {
        InputFieldView(viewData: .init(text: $viewModel.user.cpf,
                                       isSecureField: false,
                                       placeholder: "Entre com o seu CPF *",
                                       keyboard: .alphabet))
    }
    
    var cnpjField: some View {
        InputFieldView(viewData: .init(text: $viewModel.user.cnpj,
                                       isSecureField: false,
                                       placeholder: "Entre com o seu CNPJ *",
                                       keyboard: .alphabet))
    }
    
    var corporateNameField: some View {
        InputFieldView(viewData: .init(text: $viewModel.user.corporateName,
                                       isSecureField: false,
                                       placeholder: "Entre com a razão social *",
                                       keyboard: .alphabet))
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

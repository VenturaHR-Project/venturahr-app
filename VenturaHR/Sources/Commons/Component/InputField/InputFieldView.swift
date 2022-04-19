import SwiftUI

struct InputFieldView: View {
    var viewData: InputFieldViewData
    
    var body: some View {
        VStack(alignment: .leading) {
            if viewData.isSecureField {
                SecureField(viewData.placeholder, text: viewData.$text)
                    .foregroundColor(Color(R.color.blackWhite.name))
                    .keyboardType(viewData.keyboard)
                    .textFieldStyle(CustomInputFieldStyle())
            } else {
                TextField(viewData.placeholder, text: viewData.$text)
                    .foregroundColor(Color(R.color.blackWhite.name))
                    .keyboardType(viewData.keyboard)
                    .textInputAutocapitalization(viewData.autocapitalization)
                    .textFieldStyle(CustomInputFieldStyle())
            }
            
            if let errorMessage = viewData.errorMessage, viewData.hasFailure == true, !viewData.text.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
        }.padding(.bottom, 10)
    }
    
    private var inputFieldHasError: Bool {
        viewData.hasFailure == true
        && viewData.errorMessage != nil
        && !viewData.text.isEmpty
    }
}

struct InputFieldView_Previews: PreviewProvider {
    static var previews: some View {
        let viewData: InputFieldViewData = .init(text: .constant("Texto"),
                                                 isSecureField: false,
                                                 placeholder: "E-mail",
                                                 keyboard: .default,
                                                 autocapitalization: .words,
                                                 hasFailure: false,
                                                 errorMessage: "Campo inválido")
        
        ForEach(ColorScheme.allCases, id: \.self) {
            InputFieldView(viewData: viewData)
                .preferredColorScheme($0)
                .padding()
        }
    }
}

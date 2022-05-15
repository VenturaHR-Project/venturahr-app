import SwiftUI

struct VacancyEditTextField: View {
    @Binding var text: String
    
    var title: String
    var placeholder: String = ""
    var keyboard: UIKeyboardType = .default
    var autocapitalization: TextInputAutocapitalization = .words
    
    var body: some View {
        //VStack(alignment: .leading) {
        HStack {
            Text(title)
            Spacer()
            TextField(placeholder, text: $text)
                .foregroundColor(Color(R.color.blackWhite.name))
                .keyboardType(keyboard)
                .textInputAutocapitalization(autocapitalization)
                .multilineTextAlignment(.trailing)
        }
        //}
    }
}

struct VacancyEditTextField_Previews: PreviewProvider {
    static var previews: some View {
        VacancyEditTextField(text: .constant("Texto"), title: "Nome")
            .padding()
    }
}

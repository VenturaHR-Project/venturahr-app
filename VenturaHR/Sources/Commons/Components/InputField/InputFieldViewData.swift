import SwiftUI

struct InputFieldViewData {
    @Binding var text: String
    
    var isSecureField: Bool = false
    var placeholder: String = ""
    var keyboard: UIKeyboardType = .default
    var autocapitalization: TextInputAutocapitalization = .words
    var hasFailure: Bool? = nil
    var errorMessage: String? = nil
}

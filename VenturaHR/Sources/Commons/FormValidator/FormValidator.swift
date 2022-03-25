import Foundation

struct FormValidator {
    static func hasMinLenght(value: String, min: Int) -> Bool {
        return value.count < min
    }
    
    static func hasMaxLenght(value: String, min: Int) -> Bool {
        return value.count > min
    }
    
    static func isEmailValid(value: String) -> Bool {
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format:"SELF MATCHES %@", regEx).evaluate(with: value)
    }
}

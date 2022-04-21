import Foundation

extension String {
    func isEmail() -> Bool {
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        return NSPredicate(format:"SELF MATCHES %@", regEx).evaluate(with: self)
    }
    
    func hasMinLenght(value: String, min: Int) -> Bool {
        return value.count < min
    }
    
    func hasMaxLenght(value: String, max: Int) -> Bool {
        return value.count > max
    }
}

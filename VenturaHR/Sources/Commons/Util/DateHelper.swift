import Foundation

protocol DateHelperProtocol {
    func parseDateToString(value: Date) -> String
}

final class DateHelper {
    private var formatter: DateFormatter
    
    init(formatter: DateFormatter = DateFormatter()) {
        self.formatter = formatter
        setupLocale()
    }
    
    private func setupLocale() {
        formatter.locale = Locale(identifier: "en_US_POSIX")
    }
}

extension DateHelper: DateHelperProtocol {
    func parseDateToString(value: Date) -> String {
        formatter.dateFormat = "dd/MM/yyyy"
        let dateFormatted = formatter.string(from: value)
        
        return dateFormatted
    }
}

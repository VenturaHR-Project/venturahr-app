enum DesiredMinimumProfile: String, CaseIterable {
    case veryLow = "Muito baixo"
    case short = "Baixo"
    case medium = "Médio"
    case hight = "Alto"
    case veryHight = "Muito alto"
    
    var value: Int {
        switch self {
        case .veryLow: return 1
        case .short: return 2
        case .medium: return 3
        case .hight: return 4
        case .veryHight: return 5
        }
    }
    
    static func convertValueToEnum(value: Int) -> DesiredMinimumProfile {
        switch value {
        case 1: return .veryLow
        case 2: return .short
        case 3: return .medium
        case 4: return .hight
        case 5: return .veryHight
        default: return .veryLow
        }
    }
}

enum Endpoint {
    case base
    case postUser
}


extension Endpoint {
    private var baseUrl: String {
        "http://localhost:3000"
    }
    
    var value: String {
        switch self {
        case .base:
            return "\(baseUrl)"
        case .postUser:
            return "\(baseUrl)/users"
        }
    }
}

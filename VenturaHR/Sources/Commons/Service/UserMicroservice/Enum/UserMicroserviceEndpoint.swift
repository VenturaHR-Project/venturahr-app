enum UserMicroserviceEndpoint {
    case postUser
    case getUserByUID
}

extension UserMicroserviceEndpoint {
    private var baseUrl: String {
        "http://localhost:3000"
    }
    
    var value: String {
        switch self {
        case .postUser:
            return "\(baseUrl)/users"
        case .getUserByUID:
            return "\(baseUrl)/users/%d"
        }
    }
}

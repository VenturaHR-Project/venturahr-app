import Foundation

enum NetworkError: Error {
    case badRequest
    case dataNotFound
    case internalServerError
    
    case decodeFailure(_ detail: String)
    case detail(_ detail: String)
}

extension NetworkError: CustomStringConvertible {
    var description: String {
        switch self {
        case .badRequest: return "Server didn't understand the request"
        case .dataNotFound: return "No data Found"
        case .internalServerError: return "Server has encountered a situation it doesn't know how to handle."
        case let .decodeFailure(detail): return "Decode Failure: \(detail)"
        case let .detail(detail): return "Error Detail: \(detail)"
        }
    }
}

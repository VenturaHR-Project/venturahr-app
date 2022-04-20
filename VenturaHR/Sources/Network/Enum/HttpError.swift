import Foundation

enum HttpError: Error {
    case badRequest
    case notFound
    case unauthorized
    case internalServerError
}

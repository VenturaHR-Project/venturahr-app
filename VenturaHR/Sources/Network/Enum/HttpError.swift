import Foundation

enum HttpError: Error {
    case badRequest
    case unauthorized
    case notFound
    case internalServerError
}

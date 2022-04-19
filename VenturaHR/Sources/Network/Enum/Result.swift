import Foundation

enum Result {
    case success(Data)
    case failure(NetworkError, Data?)
}

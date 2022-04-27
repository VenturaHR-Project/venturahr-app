import Foundation

enum NetworkResult {
    case failure(NetworkError, Data?)
    case success(Data)
}

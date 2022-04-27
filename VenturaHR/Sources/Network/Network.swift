import Foundation

protocol NetworkProtocol {
    func call<T: Encodable>(path: String,
                            method: HttpMethod,
                            body: T,
                            completion: @escaping (NetworkResult) -> Void)
    
    func call(path: String,
              method: HttpMethod,
              completion: @escaping (NetworkResult) -> Void)
}

final class Network {
    static var shared: NetworkProtocol = Network()
    
    private lazy var sessionRest: URLSession? = {
        URLSession(configuration: .default)
    }()
    
    private func completeURL(path: String) -> URLRequest? {
        guard let url = URL(string: "\(path)") else { return nil }
        return URLRequest(url: url)
    }
    
    private func makeUrlRequest(path: String, method: HttpMethod) -> URLRequest? {
        guard var urlRequest = completeURL(path: path) else { return nil }
        
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "content-Type")
        return urlRequest
    }
    
    private func handleCallRequest(
        path: String,
        method: HttpMethod,
        contentType: ContentType,
        data: Data?,
        completion: @escaping (NetworkResult) -> Void
    ) {
        guard var urlRequest = makeUrlRequest(path: path, method: method) else { return }
        
        urlRequest.httpBody = data
        sessionRest?.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.internalServerError, nil))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200, 201:
                    completion(.success(data))
                    break
                case 400:
                    completion(.failure(.badRequest, data))
                    break
                case 404:
                    completion(.failure(.dataNotFound, data))
                    break
                case 500:
                    completion(.failure(.internalServerError, data))
                default:
                    break
                }
            }
        }.resume()
    }
}

extension Network: NetworkProtocol {
    func call<T: Encodable>(
        path: String,
        method: HttpMethod,
        body: T,
        completion: @escaping (NetworkResult) -> Void
    ) {
        guard let jsonData = try? JSONEncoder().encode(body) else { return }
        handleCallRequest(path: path, method: method, contentType: .json, data: jsonData, completion: completion)
    }
    
    func call(
        path: String,
        method: HttpMethod,
        completion: @escaping (NetworkResult) -> Void
    ) {
        handleCallRequest(path: path, method: method, contentType: .json, data: nil, completion: completion)
    }
}

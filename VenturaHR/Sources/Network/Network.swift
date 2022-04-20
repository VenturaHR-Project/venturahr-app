import Foundation

typealias BoolCallback = (Result<Bool, HttpError>) -> Void

struct Network {
    private static func completeURL(path: String) -> URLRequest? {
        guard let url = URL(string: "\(path)") else { return nil }
        return URLRequest(url: url)
    }
    
    private static func makeUrlRequest(path: String, method: HttpMethod) -> URLRequest? {
        guard var urlRequest = completeURL(path: path) else { return nil }
        
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "content-Type")
        return urlRequest
    }
    
    private static func handleCallRequest(
        path: String,
        method: HttpMethod,
        contentType: ContentType,
        data: Data?,
        callback: @escaping BoolCallback
    ) {
        guard var urlRequest = makeUrlRequest(path: path, method: method) else { return }
        
        urlRequest.httpBody = data
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                print(error ?? "")
                callback(.failure(.internalServerError))
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200, 201:
                    callback(.success(true))
                    break
                case 400:
                    callback(.failure(.badRequest))
                    break
                case 401:
                    callback(.failure(.unauthorized))
                    break
                case 404:
                    callback(.failure(.notFound))
                default:
                    break
                }
            }
        }
        task.resume()
    }
    
    
    public static func call<T: Encodable>(
        path: Endpoint,
        method: HttpMethod,
        body: T,
        callback: @escaping BoolCallback
    ) {
        guard let jsonData = try? JSONEncoder().encode(body) else { return }
        handleCallRequest(path: path.value, method: method, contentType: .json, data: jsonData, callback: callback)
    }
    
    public static func call(
        path: Endpoint,
        method: HttpMethod,
        callback: @escaping BoolCallback
    ) {
        handleCallRequest(path: path.value, method: method, contentType: .json, data: nil, callback: callback)
    }
}

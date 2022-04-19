import Foundation

struct Network {
    private static func completeURL(path: String) -> URLRequest? {
        guard let url = URL(string: NetworkConstants.Endpoint.postUser) else { return nil }
        
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
        completion: @escaping (Result) -> Void
    ) {
        guard let urlRequest = makeUrlRequest(path: path, method: method) else { return }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                print(error ?? "")
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
                case 401:
                    completion(.failure(.unauthorized, data))
                default:
                    break
                }
            }
        }
        task.resume()
    }
    
    
    public static func call<T: Encodable>(
        path: String,
        method: HttpMethod,
        body: T,
        completion: @escaping (Result) -> Void
    ) {
        guard let jsonData = try? JSONEncoder().encode(body) else { return }
        
        handleCallRequest(path: path, method: method, contentType: .json, data: jsonData, completion: completion)
    }
    
    public static func call(
        path: String,
        method: HttpMethod,
        completion: @escaping (Result) -> Void
    ) {
        handleCallRequest(path: path, method: method, contentType: .json, data: nil, completion: completion)
    }
}

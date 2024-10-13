//
//  NetworkManager.swift
//  NewsLoom
//
//  Created by Yasir on 13/10/24.
//

import Foundation
import Combine

protocol NetworkManaging {
    func request<T: Decodable>(_ endpoint: NewsAPIEndpoints) -> AnyPublisher<T, NewsAPIError>
}

class NetworkManager: NetworkManaging {
    
    private let session: URLSession
    private let apiKey = ""
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(_ endpoint: NewsAPIEndpoints) -> AnyPublisher<T, NewsAPIError> {
        
        guard let url = makeURL(for: endpoint) else {
            return Fail(error: .unexpectedError).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        request.addValue(apiKey, forHTTPHeaderField: "X-Api-Key")
        
        return session.dataTaskPublisher(for: request)
            .mapError { error in
                print(error)
                return .networkError
            }
            .flatMap { data, response -> AnyPublisher<T, NewsAPIError> in
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    return Fail(error: .unexpectedError).eraseToAnyPublisher()
                }
                
                if httpResponse.statusCode == 200 {
                    return Just(data)
                        .decode(type: T.self, decoder: JSONDecoder())
                        .mapError { error in
                            print(error)
                            return .decodingError
                        }
                        .eraseToAnyPublisher()
                } else {
                    return Just(data)
                        .decode(type: NewsAPIResponse.self, decoder: JSONDecoder())
                        .mapError { error in
                            print(error)
                            return .decodingError
                        }
                        .flatMap { response -> AnyPublisher<T, NewsAPIError> in
                            if let code = response.code,
                               let error = NewsAPIError(rawValue: code) {
                                return Fail(error: error).eraseToAnyPublisher()
                            } else {
                                return Fail(error: .unexpectedError).eraseToAnyPublisher()
                            }
                        }
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
    
    private func makeURL(for endpoint: NewsAPIEndpoints) -> URL? {
        
        guard var urlComponents = URLComponents(string: endpoint.baseURL + endpoint.path) else {
            return nil
        }
        
        urlComponents.queryItems = endpoint.parameters?.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        return urlComponents.url
    }
}

//
//  NetworkingEngine.swift
//  Zoo
//
//  Created by Paweł on 30/09/2022.
//

import Foundation
import Combine
import UIKit

protocol NetworkingEngineProtocol {
    func request<T:Codable>(endpoint: Endpoint, type: T.Type) -> AnyPublisher<[T], Error>
}

class NetworkingEngine: NetworkingEngineProtocol {
    
    func request<T:Codable>(endpoint: Endpoint, type: T.Type) -> AnyPublisher<[T], Error> {
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.baseUrl
        components.path = endpoint.path
        
        guard let url = components.url else {
            return Fail(error: NSError(domain: NetworkError.invalidURL.rawValue, code: -10001, userInfo: nil)).eraseToAnyPublisher()
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method
        
        let session = URLSession(configuration: .default)
          return  session
                .dataTaskPublisher(for: urlRequest)
                .retry(2)
                .tryMap { (data, response) -> Data in
                    print("DATA: \(data)")
                    guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                        throw NetworkError.responseError
                    }
                    return data
                }
                .decode(type: [T].self, decoder: JSONDecoder())
                .eraseToAnyPublisher()
    }
    
//    func downloadTaskPublisher(with url: URL) -> AnyPublisher<UIImage?, Never> {
//        //        if let image = cache[url] {
//        //                return Just(image).eraseToAnyPublisher()
//        //            }
//        return URLSession.shared.dataTaskPublisher(for: url)
//            .map { UIImage(data: $0.data) }
//            .catch { error in return Just(nil) }
//            .handleEvents(receiveOutput: { image in
//            })
//            .subscribe(on: DispatchQueue.global(qos: .background))
//            .receive(on: DispatchQueue.main)
//            .eraseToAnyPublisher()
//    }
}

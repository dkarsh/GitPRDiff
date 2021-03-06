//
//  ApiCall.swift
//  GitPRDiff
//
//  Created by Daniel Karsh on 3/6/21.
//

import Foundation
import Combine

struct APIClient {

    struct Response<T> {
        let value: T
        let response: URLResponse
    }
    
    func run<T: Decodable>(_ request: URLRequest) -> AnyPublisher<Response<T>, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { result -> Response<T> in
                if let json = try? JSONDecoder().decode(T.self, from: result.data){
                    return Response(value: json, response: result.response)
                }
                let value = String(decoding: result.data, as: UTF8.self)
                return Response(value: value as! T, response: result.response)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

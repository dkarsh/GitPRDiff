//
//  GitHubCalls.swift
//  GitPRDiff
//
//  Created by Daniel Karsh on 3/6/21.
//

import Foundation
import Combine




enum GitHubPR {
    static let apiClient = APIClient()
    static let baseUrl = URL(string: "https://api.github.com/")!
}


enum APIPath {
    case reposPullRequest
    case reposPullRequesNumber(Int)
    
    var url:String {
        switch self {
        case .reposPullRequest:
            return "repos/magicalpanda/MagicalRecord/pulls"
        case .reposPullRequesNumber(let number):
            return "repos/magicalpanda/MagicalRecord/pulls/\(number)"
        }
    }
    
    var headers:KeyValuePairs<String,String>{
        switch self {
        case .reposPullRequest:
            return [:]
        case .reposPullRequesNumber(_):
            return ["Accept":"application/vnd.github.VERSION.diff"]
        }
    }
    
    var parameters:KeyValuePairs<String,String>{
        switch self {
        case .reposPullRequest:
            return ["state":"open"]
        case .reposPullRequesNumber(_):
            return [:]
        }
    }
}

extension GitHubPR {
    static func request<T:Decodable>(_ path: APIPath) -> AnyPublisher<T, Error> {
        guard var components = URLComponents(url: baseUrl.appendingPathComponent(path.url), resolvingAgainstBaseURL: true)
            else { fatalError("Couldn't create URLComponents") }
        var queryItems = [URLQueryItem]()
        for param in path.parameters {
            queryItems.append(URLQueryItem(name: param.key, value:param.value))
        }
        components.queryItems = queryItems
        var request = URLRequest(url: components.url!)
        for header in path.headers {
            request.setValue(header.1, forHTTPHeaderField: header.0)
        }
       
        return apiClient.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}

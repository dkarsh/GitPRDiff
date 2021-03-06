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
    
    var params:KeyValuePairs<String,String>{
        switch self {
        case .reposPullRequest:
            return [:]
        case .reposPullRequesNumber(_):
            return ["Accept":"application/vnd.github.VERSION.diff"]
        }
    }
}

extension GitHubPR {
    static func request<T:Decodable>(_ path: APIPath) -> AnyPublisher<T, Error> {
        guard let components = URLComponents(url: baseUrl.appendingPathComponent(path.url), resolvingAgainstBaseURL: true)
            else { fatalError("Couldn't create URLComponents") }
        var request = URLRequest(url: components.url!)
        for params in path.params {
            request.setValue(params.1, forHTTPHeaderField: params.0)
        }
        return apiClient.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}

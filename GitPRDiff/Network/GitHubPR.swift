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


enum APIPath: String {
    case reposPullRequest = "repos/magicalpanda/MagicalRecord/pulls"
}

extension GitHubPR {
    static func request(_ path: APIPath) -> AnyPublisher<[PullRequest], Error> {
        guard let components = URLComponents(url: baseUrl.appendingPathComponent(path.rawValue), resolvingAgainstBaseURL: true)
            else { fatalError("Couldn't create URLComponents") }
        let request = URLRequest(url: components.url!)
        return apiClient.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}

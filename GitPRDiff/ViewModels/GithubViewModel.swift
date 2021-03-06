//
//  GithubViewModel.swift
//  GitPRDiff
//
//  Created by Daniel Karsh on 3/6/21.
//

import Foundation
import Combine

class GithubViewModel: ObservableObject {
    
    @Published var pulls: [PullRequest] = []
    @Published var filesOnPr: [FileChanged] = []
    
    var cancellationToken: AnyCancellable?
    
    init() {
        getPulls()
    }
    
}

extension GithubViewModel {
    
    // Subscriber implementation
    func getPulls() {
        cancellationToken = GitHubPR.request(.reposPullRequest) // 4
            .mapError({ (error) -> Error in
                print(error)
                return error
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: {
                    self.pulls = $0
            })
    }
    
    func getPullNumber(_ n:Int) {
        cancellationToken = GitHubPR.request(.reposPullRequest) // 4
            .mapError({ (error) -> Error in
                print(error)
                return error
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: {
                    self.pulls = $0
            })
//        let url = URL(string: "https://api.github.com/repos/magicalpanda/MagicalRecord/pulls/1293")!
//        var request = URLRequest(url: url)
//        request.setValue("keep-alive", forHTTPHeaderField: "Connection")
//        request.setValue("application/vnd.github.VERSION.diff", forHTTPHeaderField: "Accept")
//        request.httpMethod = "GET"
    }
    
}

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
    @Published var files: [FileChanged] = []
    
    var stringResponse:String = "" {
        didSet{
            files = FileChanged.parseStringsToFiles(stringResponse)
        }
    }
    
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
        cancellationToken = GitHubPR.request(.reposPullRequesNumber(n)) // 4
            .mapError({ (error) -> Error in
                print(error)
                return error
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: {
                    self.stringResponse = $0
                  })
    }
    
}

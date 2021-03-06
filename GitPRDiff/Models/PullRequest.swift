//
//  PullRequest.swift
//  GitPRDiff
//
//  Created by Daniel Karsh on 3/6/21.
//

import Foundation

struct PullRequest: Codable, Identifiable {
    let id: Int
    let url: String
    let title: String
    let state:String
    let number:Int
}

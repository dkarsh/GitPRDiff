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
    let user:User
    let created_at:String
    
    var hashNumber: String {
        return "#\(String(number)) "
    }
    
    var openOn: String {
        let formatter = DateFormatter()
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "MMM d, y"
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = formatter.date(from: created_at) {
            return "opened on \(formatter2.string(from: date))"
        }
        return ""
    }
    
    var subTitle: String {
        return hashNumber + openOn + " by " + user.login
    }
}

struct User: Codable, Identifiable {
    let id: Int
    let login: String
    let avatar_url: String
}

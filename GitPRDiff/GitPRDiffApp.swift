//
//  GitPRDiffApp.swift
//  GitPRDiff
//
//  Created by Daniel Karsh on 3/5/21.
//

import SwiftUI

@main
struct GitPRDiffApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            GithubView()
        }
    }
}

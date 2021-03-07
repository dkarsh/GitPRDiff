//
//  GithubView.swift
//  GitPRDiff
//
//  Created by Daniel Karsh on 3/6/21.
//

import SwiftUI

struct GithubView: View {
    
    @StateObject var viewModel = GithubViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.pulls) { pr in
                NavigationLink(destination: GithubPRView(prNumber:pr.number)) {
                    VStack(alignment: .leading) {
                        Text(pr.title)
                            .font(.headline)
                        Text(pr.subTitle)
                            .font(.subheadline)
                    }
                }
            } .navigationBarTitle("Github Pull Requests", displayMode: .inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    

    
    
}

struct GithubView_Previews: PreviewProvider {
    
    static var previews: some View {
        GithubView()
    }
}

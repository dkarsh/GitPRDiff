//
//  GithubView.swift
//  GitPRDiff
//
//  Created by Daniel Karsh on 3/6/21.
//

import SwiftUI

struct GithubView: View {
    
    @ObservedObject var viewModel = GithubViewModel()
    
    var body: some View {
        List(viewModel.pulls) { pr in
            HStack {
                VStack(alignment: .leading) {
                    Text(pr.title)
                        .font(.headline)
                    Text(pr.url)
                        .font(.subheadline)
                }
            }
        }
    }
}

struct GithubView_Previews: PreviewProvider {
    
    static var previews: some View {
        GithubView()
    }
}

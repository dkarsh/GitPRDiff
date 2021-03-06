//
//  GithubPRView.swift
//  GitPRDiff
//
//  Created by Daniel Karsh on 3/6/21.
//

import SwiftUI

struct GithubPRView: View {
    
    @EnvironmentObject var viewModel:GithubViewModel
    
    var prNumber:Int
    
    var body: some View {
        List(viewModel.files) { pr in
            Text(String(pr.chuncks.count))
            
        }.onAppear(perform: screenRotate)
    }

    func screenRotate() {
        viewModel.getPullNumber(prNumber)
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
        UIViewController.attemptRotationToDeviceOrientation()
    }

}

struct GithubPRView_Previews: PreviewProvider {
    static var previews: some View {
        GithubPRView(prNumber:0)
    }
}

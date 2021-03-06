//
//  GithubPRView.swift
//  GitPRDiff
//
//  Created by Daniel Karsh on 3/6/21.
//

import SwiftUI

struct GithubPRView: View {
    
    @EnvironmentObject var viewModel:GithubViewModel
    
    var prNumber:Int {
        didSet{
            viewModel.getPullNumber(prNumber)
        }
    }
    
    
    var body: some View {
        List(viewModel.pulls) { pr in
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear(perform: screenRotate)
        }
    }
    
    func screenRotate() {
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
        UIViewController.attemptRotationToDeviceOrientation()
    }

}

struct GithubPRView_Previews: PreviewProvider {
    static var previews: some View {
        GithubPRView(prNumber:0)
    }
}

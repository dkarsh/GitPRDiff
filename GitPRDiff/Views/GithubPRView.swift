//
//  GithubPRView.swift
//  GitPRDiff
//
//  Created by Daniel Karsh on 3/6/21.
//

import SwiftUI

struct GithubPRView: View {
    
    @StateObject var viewModel = GithubViewModel()
    
    var prNumber:Int {
        didSet {
            viewModel.diffList = nil
        }
    }
    
    var body: some View {
        VStack{
            viewModel.diffList.map{theList($0)}
        }
        .onAppear(perform: getPullRequest)
        .onAppear(perform: landscapeLeft)
        .onDisappear(perform: portrait)
    }
    
    
    func theList(_ list:DiffList) -> some View {
        return
            ScrollView{
                LazyVStack {
                    ForEach(0..<list.aSide.count){ i in
                        HStack{
                            
                            let lineA = list.aSide[i]
                            let lineB = list.bSide[i]
                            
                            if lineA.type == .bFileName {
                                TextSideView(line:lineA)
                                    .padding(.vertical,10)
                            }else if lineA.type == .diffInfo {
                                TextSideView(line:lineA)
                            }else{
                                TextSideView(line:lineA)
                                TextSideView(line:lineB)
                            }
                        }
                    }
                }
            }
    }
    
    func getPullRequest() {
        viewModel.getPullNumber(prNumber)
    }
    
    func landscapeLeft(){
        AppDelegate.orientationLock = UIInterfaceOrientationMask.landscapeLeft
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
        UIViewController.attemptRotationToDeviceOrientation()
    }
    
    func portrait(){
        AppDelegate.orientationLock = UIInterfaceOrientationMask.portrait
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        UIViewController.attemptRotationToDeviceOrientation()
    }
    
}

struct GithubPRView_Previews: PreviewProvider {
    static var previews: some View {
        GithubPRView(prNumber:0)
    }
}

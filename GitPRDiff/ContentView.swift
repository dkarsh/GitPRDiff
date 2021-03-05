//
//  ContentView.swift
//  GitPRDiff
//
//  Created by Daniel Karsh on 3/5/21.
//

import SwiftUI

struct ContentView: View {
    
    func loadData() {
        
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
        UIViewController.attemptRotationToDeviceOrientation()
        
        let url = URL(string: "https://api.github.com/repos/magicalpanda/MagicalRecord/pulls/1293")!
        var request = URLRequest(url: url)
        request.setValue("keep-alive", forHTTPHeaderField: "Connection")
        request.setValue("application/vnd.github.VERSION.diff", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
            let str = String(decoding: data, as: UTF8.self)
            let myStrings = str.components(separatedBy: .newlines)
            let formatedLines = myStrings.enumerated().map { OneLine($1,id:$0) }
            let linesType = formatedLines.map{$0.type}
                print(linesType)
             
            }
        }.resume()
        
    }
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear(perform: loadData)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  FileChanged.swift
//  GitPRDiff
//
//  Created by Daniel Karsh on 3/5/21.
//

import Foundation


struct FileChanged {
    var id:Int
    var title: String
    var chuncks:[ChunckChanged]
    
    init(fileLines:[OneLine], id:Int) {
        
        self.id = id
        let _chuncks = fileLines.split {$0.type == .diffInfo}
        let _chuncksArray = _chuncks.map{Array($0)}
        chuncks = _chuncksArray.map{ ChunckChanged(fileLines: $0, id: id)}
     
        title = ""
   
    }
    
    
}



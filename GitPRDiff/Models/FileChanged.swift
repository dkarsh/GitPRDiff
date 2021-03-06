//
//  FileChanged.swift
//  GitPRDiff
//
//  Created by Daniel Karsh on 3/5/21.
//

import Foundation

struct FileChanged: Codable, Identifiable  {
    
    let id:Int
    let title: String
    let chuncks:[ChunckChanged]
    
    init(fileLines:[OneLine], id:Int) {
        self.id = id
        let _chuncks = fileLines.split {$0.type == .diffInfo}
        let _chuncksArray = _chuncks.map{Array($0)}
        chuncks = _chuncksArray.map{ ChunckChanged(fileLines: $0, id: id)}
     
        title = ""
    }
    
    // https://stackoverflow.com/questions/33830047/arrayslice-in-array-swift
    
    static func parseStringsToFiles(_ s:String) -> [FileChanged] {
        let myStrings = s.components(separatedBy: .newlines)
        let formatedLines = myStrings.enumerated().map { OneLine($1,id:$0) }
        let cleanDiffandIndexLines = formatedLines.filter{$0.type != .diff}.filter{$0.type != .index}
        let splitIntoFiles = cleanDiffandIndexLines.split { $0.type == .aFileName }
        let filesArray = splitIntoFiles.map{Array($0)}
        return filesArray.map{FileChanged(fileLines: $0,id:1)}
    }
}



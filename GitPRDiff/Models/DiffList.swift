//
//  ChunckChanged.swift
//  GitPRDiff
//
//  Created by Daniel Karsh on 3/5/21.
//

import Foundation

struct DiffList  {
    
    var title = ""
    var aSide = [OneLine]()
    var bSide = [OneLine]()
    
    static func parseStringsToDiffList(_ s:String) -> DiffList {
        let myStrings = s.components(separatedBy: .newlines)
        let formatedLines = myStrings.enumerated().map { OneLine($1,id:$0) }
        let difflist = DiffList(fileLines:formatedLines)
        return difflist
    }
    
    init(fileLines:[OneLine]) {
  
        for line in fileLines {
            switch line.type {
            case .aFileName:
                break
            case .addLine:
                bSide.append(line)
            case .bFileName:
                aSide.append(line)
            case .deleteLine:
                aSide.append(line)
            case .diff:
                break
            case .diffInfo:
                aSide.append(line)
                bSide.append(line)
            case .index:
                break
            case .line:
                let n = aSide.count - bSide.count
                if n>0 {
                    bSide.append(contentsOf: Array(repeating:OneLine("", id: line.id), count:n))
                } else if n<0{
                    aSide.append(contentsOf: Array(repeating:OneLine("", id: line.id), count:abs(n)))
                }
            aSide.append(line)
            bSide.append(line)
            }
       
        }
    }
}

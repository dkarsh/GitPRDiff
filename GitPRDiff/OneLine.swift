//
//  OneLine.swift
//  GitPRDiff
//
//  Created by Daniel Karsh on 3/5/21.
//

// https://stackoverflow.com/questions/2529441/how-to-read-the-output-from-git-diff

import Foundation

enum LineType:String {
    case diff = "d"
    case index = "i"
    case diffInfo = "@"
    case aFileName = "---"
    case bFileName = "+++"
    case line = " "
    case deleteLine = "-"
    case addLine = "+"
    

    var removeString: String {
        switch self {
        case .diff:
            return "diff --git"
        case .index:
            return "index"
        case .diffInfo:
            return "@@"
        case .aFileName:
            return "--- a/"
        case .bFileName:
            return "+++ b/"
        case .line:
            return " "
        case .deleteLine:
            return "-"
        case .addLine:
            return "+"
        }
    }
    
//    func cleanText(_ str:String) -> String {
//        if self == .
//        return String(str.dropFirst(self.removeString.count))
//    }
}

struct OneLine {
    var text:String
    var type:LineType
    var id:Int
    
    init(_ raw:String, id:Int) {
        if raw.hasPrefix(LineType.aFileName.rawValue) {
            self.type = .aFileName
        }else if raw.hasPrefix(LineType.bFileName.rawValue){
            self.type = .bFileName
        }else{
            self.type = LineType(rawValue:String(raw.first ?? " ")) ?? .line
        }
        self.text = raw
        self.id = id
    }
}


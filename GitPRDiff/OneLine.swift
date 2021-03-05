//
//  OneLine.swift
//  GitPRDiff
//
//  Created by Daniel Karsh on 3/5/21.
//

import Foundation

enum LineType {
    case diff
    case index
    case diffInfo
    case aFileName
    case bFileName
    case line
    case deleteLine
    case addLine
    
    var prefix: String {
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
            return ""
        case .deleteLine:
            return "-"
        case .addLine:
            return "+"
        }
    }
}

struct LineEntry {
    var text:String
    var type:LineType
    var id:Int
}

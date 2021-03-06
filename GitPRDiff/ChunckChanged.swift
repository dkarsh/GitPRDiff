//
//  ChunckChanged.swift
//  GitPRDiff
//
//  Created by Daniel Karsh on 3/5/21.
//

import Foundation

struct ChunckChanged {
    var id:Int
    var title = ""
    var aSide = [OneLine]()
    var bSide = [OneLine]()
    
    private var deleteFilesOn = false
    private var addFilesOn = false
    
    init(fileLines:[OneLine], id:Int) {
        self.id = id
        for line in fileLines {
            if line.type == .diffInfo {
                title = line.text
            }else if line.type == .deleteLine {
                aSide.append(line)
                deleteFilesOn = true
            }else if line.type == .addLine {
                bSide.append(line)
                addFilesOn = true
            }else if line.type == .line {
                if (addFilesOn && deleteFilesOn) {
                    addFilesOn = false
                    deleteFilesOn = false
                    let n = aSide.count - bSide.count
                    if n>0 {
                        bSide.append(contentsOf: Array(repeating:OneLine("", id: 0), count:n))
                    } else if n<0{
                        aSide.append(contentsOf: Array(repeating:OneLine("", id: 0), count:abs(n)))
                    }
                }
                    aSide.append(line)
                    bSide.append(line)
                }
            }
        
        }
}

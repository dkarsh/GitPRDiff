//
//  TextSideView.swift
//  GitPRDiff
//
//  Created by Daniel Karsh on 3/6/21.
//

import SwiftUI

struct TextSideView: View {
    
    var line:OneLine
    
    var color:Color{
        if line.type == .deleteLine {
            return Color.red.opacity(0.3)
        }else if line.type == .addLine {
            return Color.green.opacity(0.3)
        }else if line.type == .diffInfo {
            return Color.gray.opacity(0.3)
        }else if line.type == .bFileName {
            return Color.black.opacity(0.3)
        }
        return Color.clear
    }
    
    var text:String{
        if line.type == .bFileName {
            return String(line.text.dropFirst(6))
        }
        return line.text
    }
    
    var body: some View {
        VStack{
            HStack{
                Text(text)
                Spacer()
            }
            Spacer()
        }
        .background(color)
    }
}


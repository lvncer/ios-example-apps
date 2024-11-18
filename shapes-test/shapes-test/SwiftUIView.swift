//
//  SwiftUIView.swift
//  shapes-test
//
//  Created by classmac on 2024/11/18.
//

import SwiftUI

struct SwiftUIView: View {
    @State var volume: Double = 0.0
    var body: some View {
        VStack(spacing: 50) {
            GroupBox {
                Slider(value: $volume)
                Text("\(format(volume))").font(.largeTitle)
            }.frame(width: 300)
            // 可変カラーシンボル
            Image(systemName: "speaker.wave.3",
                  variableValue: volume)
            .resizable()
            .frame(width: 100, height: 100)
        }
    }
}
// 小数点以下を２桁にする
func format(_ num:Double) -> String {
    let result = String(round(num*100)/100)
    return result
}

#Preview {
    SwiftUIView()
}

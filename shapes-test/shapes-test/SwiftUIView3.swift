//
//  SwiftUIView3.swift
//  shapes-test
//
//  Created by classmac on 2024/11/18.
//

import SwiftUI

struct SwiftUIView3: View {
    var body: some View {
        List {
            Text("Content 1")
            Text("Content 2")
            Label("カート", systemImage: "cart")
                .font(.largeTitle)
            Text("Content 4")
            Photo().frame(height: 150)
            Text("Content 6")
        }
    }
}
// 写真
struct Photo: View {
    var body: some View {
        HStack {
            Image("li")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text("灯台")
                .padding(.horizontal)
        }
    }
}

#Preview {
    SwiftUIView3()
}

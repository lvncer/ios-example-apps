//
//  ContentView.swift
//  shapes-test
//
//  Created by classmac on 2024/11/18.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Ellipse()
            .foregroundColor(.orange)
            .frame(width: 200, height: 400)
            .rotationEffect(.degrees(45))
            .clipped()
    }
}

#Preview {
    ContentView()
}

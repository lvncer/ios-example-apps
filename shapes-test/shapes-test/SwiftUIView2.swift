//
//  SwiftUIView2.swift
//  shapes-test
//
//  Created by classmac on 2024/11/18.
//

import SwiftUI

struct SwiftUIView2: View {
    var body: some View {
        Rectangle()
            .frame(width:300, height: 300)
            .foregroundStyle(
                AngularGradient(
                    gradient: Gradient(colors: [.yellow, .red, .blue, .yellow]),
                    center: .init(x: 0.5, y: 0.2),
                    startAngle: .degrees(0),
                    endAngle: .degrees(180))
            )
    }
}

#Preview {
    SwiftUIView2()
}

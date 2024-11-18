import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack(spacing: 50) {
            Image(systemName: "thermometer.sun.fill")
                .font(.system(size: 100))
                .symbolRenderingMode(.monochrome)
            Image(systemName: "thermometer.sun.fill")
                .font(.system(size: 100))
                .symbolRenderingMode(.monochrome)
                .foregroundStyle(.red.gradient)
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer()
            // Title section
            Text("『奥の細道』")
                .font(.system(size: 48, weight: .bold))
                .padding(.bottom, 4)
                .frame(maxWidth: .infinity, alignment: .center)

            // Subtitle
            Text("岩手県平泉にて")
                .font(.system(size: 24))
                .padding(.bottom, 16)
                .frame(maxWidth: .infinity, alignment: .center)

            // Image
            Image(.test)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
                .clipped()
                .padding(.bottom, 16)
            
            // Quote and author
            VStack(alignment: .leading, spacing: 8) {
                Text("「夏草や")
                    .font(.system(size: 32))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("兵どもが 夢の後」")
                    .font(.system(size: 32))
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }

            Text("松尾芭蕉")
                .font(.system(size: 32))
                .padding(.top, 8)
                .frame(maxWidth: .infinity, alignment: .trailing)
            
            Spacer()
        }
        .padding(.horizontal, 16) // Adding the 10-20px padding from edges
        .padding(.vertical, 20)
    }
}
#Preview {
    ContentView()
}

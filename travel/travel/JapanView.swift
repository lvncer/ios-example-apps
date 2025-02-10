import SwiftUI

struct JapanView: View {
    var body: some View {
        VStack {
            Text("🇯🇵 Japan")
                .font(.largeTitle)
                .padding()
            Image("japan")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .padding()
            
            VStack(alignment: .leading) {
                Text("おすすめスポット:")
                    .font(.headline)
                    .padding(.top)
                Text("- 東京: スカイツリー, 浅草, 渋谷")
                Text("- 京都: 清水寺, 金閣寺, 伏見稲荷")
                Text("- 大阪: ユニバーサル・スタジオ・ジャパン, 道頓堀")
            }
            .padding()
        }
        .navigationTitle("Japan")
    }
}

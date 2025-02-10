import SwiftUI

struct UKView: View {
    var body: some View {
        VStack {
            Text("🇬🇧 UK")
                .font(.largeTitle)
                .padding()
            Image("3121")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .padding()
            Text("イギリスの詳細ページです。")
                .font(.title2)
                .padding()
            
            VStack(alignment: .leading) {
                Text("おすすめスポット:")
                    .font(.headline)
                    .padding(.top)
                Text("- ロンドン: ビッグ・ベン, バッキンガム宮殿")
                Text("- エディンバラ: エディンバラ城, 王宮")
                Text("- マンチェスター: フットボール博物館")
            }
            .padding()
        }
        .navigationTitle("UK")
    }
}


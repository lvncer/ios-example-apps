import SwiftUI

struct KoreaView: View {
    var body: some View {
        VStack {
            Text("🇰🇷 South Korea")
                .font(.largeTitle)
                .padding()
            Image("skorea")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .padding()
            Text("韓国の詳細ページです。")
                .font(.title2)
                .padding()
            
            VStack(alignment: .leading) {
                Text("おすすめスポット:")
                    .font(.headline)
                    .padding(.top)
                Text("- ソウル: 景福宮, 明洞, Nソウルタワー")
                Text("- 釜山: 海雲台ビーチ, 甘川文化村")
            }
            .padding()
        }
        .navigationTitle("South Korea")
    }
}


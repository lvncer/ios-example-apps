import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("🌏 Asia")) {
                    NavigationLink(destination: JapanView()) {
                        Text("🇯🇵 Japan")
                            .font(.title2)
                            .padding(.vertical, 5)
                    }
                    NavigationLink(destination: KoreaView()) {
                        Text("🇰🇷 South Korea")
                            .font(.title2)
                            .padding(.vertical, 5)
                    }
                }
                
                Section(header: Text("🌍 Europe")) {
                    NavigationLink(destination: UKView()) {
                        Text("🇬🇧 UK")
                            .font(.title2)
                            .padding(.vertical, 5)
                    }
                    NavigationLink(destination: FranceView()) {
                        Text("🇫🇷 France")
                            .font(.title2)
                            .padding(.vertical, 5)
                    }
                }
            }
            .navigationTitle("旅行提案アプリ")
        }
    }
}

struct FranceView: View {
    var body: some View {
        VStack {
            Text("🇫🇷 France")
                .font(.largeTitle)
                .padding()
            Image("france")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .padding()
            Text("フランスの詳細ページです。")
                .font(.title2)
                .padding()
            
            VStack(alignment: .leading) {
                Text("おすすめスポット:")
                    .font(.headline)
                    .padding(.top)
                Text("- パリ: エッフェル塔, ルーブル美術館, 凱旋門")
                Text("- ニース: プロムナード・デ・ザングレ, ニース旧市街")
            }
            .padding()
        }
        .navigationTitle("France")
    }
}

#Preview {
    ContentView()
}


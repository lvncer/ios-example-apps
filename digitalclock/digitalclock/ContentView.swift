import SwiftUI

struct ContentView: View {
    @State private var currentTime = Date()
    
    // タイマーを使って毎秒更新
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            ZStack {
                // 時計の円
                Circle()
                    .stroke(lineWidth: 15)
                    .foregroundColor(Color.gray)
                    .frame(width: 300, height: 300)
                
                // 時針のアニメーション
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 8, height: 80)
                    .offset(y: -40)
                    .rotationEffect(Angle(degrees: getHourAngle()))
                    .animation(.linear(duration: 60), value: currentTime)
                    .onReceive(timer) { _ in
                        currentTime = Date()
                    }
                
                // 分針のアニメーション
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 6, height: 100)
                    .offset(y: -50)
                    .rotationEffect(Angle(degrees: getMinuteAngle()))
                    .animation(.linear(duration: 60), value: currentTime)
                    .onReceive(timer) { _ in
                        currentTime = Date()
                    }
                
                // 秒針のアニメーション
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 2, height: 120)
                    .offset(y: -60)
                    .rotationEffect(Angle(degrees: getSecondAngle()))
                    .animation(.linear(duration: 1), value: currentTime)
                    .onReceive(timer) { _ in
                        currentTime = Date()
                    }
                
                // 時計の中心
                Circle()
                    .fill(Color.white)
                    .frame(width: 20, height: 20)
            }
            .padding(50)
        }
        .background(Color.black.edgesIgnoringSafeArea(.all)) // 背景を黒に設定
        .onAppear {
            currentTime = Date() // 初回表示時に現在時刻を設定
        }
    }
    
    // 時針の角度を計算
    func getHourAngle() -> Double {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: currentTime)
        let minute = calendar.component(.minute, from: currentTime)
        
        let hourAngle = Double(hour % 12) * 30  // 1時間あたり30度
        let minuteAdjustment = Double(minute) * 0.5  // 1分あたり0.5度
        
        return hourAngle + minuteAdjustment
    }
    
    // 分針の角度を計算
    func getMinuteAngle() -> Double {
        let calendar = Calendar.current
        let minute = calendar.component(.minute, from: currentTime)
        return Double(minute) * 6 // 1分あたり6度
    }
    
    // 秒針の角度を計算
    func getSecondAngle() -> Double {
        let calendar = Calendar.current
        let second = calendar.component(.second, from: currentTime)
        return Double(second) * 6 // 1秒あたり6度
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


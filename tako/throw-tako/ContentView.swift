import SwiftUI
struct ContentView: View {
    @State private var positionX: CGFloat = 0 // X 位置
    @State private var positionY: CGFloat = 0 // Y 位置
    @State private var time: CGFloat = 0 // 時間経過
    @State private var isThrown = false // 投げるフラグ
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    let flightDuration: TimeInterval = 2.5 // 放物線の飛行時間
    let gravity: CGFloat = 500 // 重力加速度 (調整可能)
    let startX: CGFloat
    let startY: CGFloat
    let peakHeight: CGFloat
    let landingX: CGFloat
    let landingY: CGFloat
    
    init() {
        startX = screenWidth * 0.1 // 画面左端 10%
        startY = screenHeight * 0.85 // 画面下部 85%
        peakHeight = screenHeight * 0.2 // 画面上部 20% (放物線の最高点)
        landingX = screenWidth * 0.9 // 画面右端 90%
        landingY = screenHeight * 0.85 // 画面下部 85% (着地)
    }
    var body: some View {
        ZStack {
            Image("tako")
                .resizable()
                .frame(width: 100, height: 100)
                .position(x: positionX, y: positionY)
                .onTapGesture {
                    throwTako()
                }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.blue.opacity(0.2)) // 背景を追加して視認性を向上
        .onAppear {
            positionX = startX
            positionY = startY
        }
    }
    func throwTako() {
        guard !isThrown else { return } // すでに投げられていたら無視
        isThrown = true
        time = 0 // 投げるたびにリセット
        let velocityX: CGFloat = (landingX - startX) / CGFloat(flightDuration) // x 方向の速度
        let velocityY: CGFloat = -sqrt(2 * gravity * (startY - peakHeight)) // y 方向の初速度 (放物線の高さを考慮)
        Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { timer in
            time += 0.02
            
            let newX = startX + velocityX * time
            let newY = startY + velocityY * time + 0.5 * gravity * pow(time, 2)
            DispatchQueue.main.async {
                withAnimation(.linear(duration: 0.02)) {
                    positionX = newX
                    positionY = newY
                }
            }
            // 着地したら停止
            if newX >= landingX || newY >= landingY {
                timer.invalidate()
                positionX = landingX
                positionY = landingY
                isThrown = false // 投げ直し可能にする
            }
        }
    }
}
#Preview {
    ContentView()
}

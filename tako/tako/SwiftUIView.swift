import SwiftUI

struct SwiftUIView: View {
    @State private var position1: CGPoint = CGPoint(x: 150, y: 250) // 1 匹目の初期位置
    @State private var position2: CGPoint = CGPoint(x: 250, y: 350) // 2 匹目の初期位置
    @State private var isTako1Visible: Bool = true // 1 匹目の表示状態
    @State private var isTako2Visible: Bool = true // 2 匹目の表示状態
    @State private var isGameOver: Bool = false // ゲーム終了フラグ
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    let takoSize: CGFloat = 100 // `tako` のサイズ(画像の幅と高さ)
    let collisionThreshold: CGFloat = 100 - 1 // より正確な衝突判定
    let moveInterval: TimeInterval = 1.5 // 移動速度
    
    var body: some View {
        ZStack {
            // 1 匹目の `tako`
            if isTako1Visible {
                Image("tako")
                    .resizable()
                    .frame(width: takoSize, height: takoSize)
                    .position(position1)
                    .onAppear {
                        startMovingTako1()
                    }
            }
            // 2 匹目の `tako`
            if isTako2Visible {
                Image("tako")
                    .resizable()
                    .frame(width: takoSize, height: takoSize)
                    .position(position2)
                    .onAppear {
                        startMovingTako2()
                    }
            }
            
            // ゲーム終了メッセージ
            if isGameOver {
                Text("Game Over")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.red)
                    .position(x: screenWidth / 2, y: screenHeight / 2)
            }
        }
    }
    // 1 匹目の `tako` をランダムに移動
    func startMovingTako1() {
        Timer.scheduledTimer(withTimeInterval: moveInterval, repeats: true) { timer in
            if isGameOver { timer.invalidate(); return } // ゲーム終了時に停止
            if isTako1Visible {
                withAnimation(.easeInOut(duration: moveInterval)) {
                    let newPosition = CGPoint(
                        x: CGFloat.random(in: max(50, position1.x -
                                                  200)...min(screenWidth - 50, position1.x + 200)),
                        y: CGFloat.random(in: max(100, position1.y -
                                                  200)...min(screenHeight - 100, position1.y + 200))
                    )
                    position1 = newPosition
                }
                checkCollision()
            }
        }
    }
    // 2 匹目の `tako` をランダムに移動
    func startMovingTako2() {
        Timer.scheduledTimer(withTimeInterval: moveInterval, repeats: true) { timer
            in
            if isGameOver { timer.invalidate(); return } // ゲーム終了時に停止
            if isTako2Visible {
                withAnimation(.easeInOut(duration: moveInterval)) {
                    let newPosition = CGPoint(
                        
                        x: CGFloat.random(in: max(50, position2.x -
                                                  
                                                  200)...min(screenWidth - 50, position2.x + 200)),
                        
                        y: CGFloat.random(in: max(100, position2.y -
                                                  
                                                  200)...min(screenHeight - 100, position2.y + 200))
                        
                    )
                    position2 = newPosition
                }
                checkCollision()
            }
        }
    }
    // **より正確な衝突判定**
    func checkCollision() {
        let distance = sqrt(pow(position1.x - position2.x, 2) + pow(position1.y -
                                                                    position2.y, 2))
        if distance < collisionThreshold { // 画像の端がちょうど重なったら衝突
            print("���������������������� 正確な衝突!(端が重なった)")
            removeRandomTako()
        }
    }
    // 衝突後、どちらかの `tako` を消し、もう一方を停止
    func removeRandomTako() {
        withAnimation(.easeOut(duration: 0.5)) {
            if Bool.random() { // ランダムに 1 匹を消す
                isTako1Visible = false
            } else {
                isTako2Visible = false
            }
            isGameOver = true // もう一方の `tako` も停止
        }
    }
}
#Preview {
    ContentView()
}

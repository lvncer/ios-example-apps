import SwiftUI

// 弾やエイリアンに一意のIDを付与するための構造体
struct Bullet: Identifiable {
    var id = UUID()
    var frame: CGRect
}

struct Alien: Identifiable {
    var id = UUID()
    var frame: CGRect
}

struct ContentView: View {
    @State private var playerPosition = CGSize(width: 150, height: 550)
    @State private var playerSpeed: CGFloat = 10
    @State private var bullets: [Bullet] = []
    @State private var aliens: [Alien] = []
    @State private var score = 0
    @State private var gameOver = false
    
    let alienSpeed: CGFloat = 1
    let bulletSpeed: CGFloat = 15
    
    var body: some View {
        VStack {
            if gameOver {
                Text("Game Over")
                    .font(.largeTitle)
                    .foregroundColor(.red)
                Text("Score: \(score)")
                    .font(.title)
            } else {
                ZStack {
                    Color.black.edgesIgnoringSafeArea(.all)
                    
                    // プレイヤー
                    Rectangle()
                        .frame(width: 50, height: 20)
                        .position(x: playerPosition.width, y: playerPosition.height)
                        .foregroundColor(.green)
                    
                    // 弾
                    ForEach(bullets) { bullet in
                        Rectangle()
                            .frame(width: 5, height: 20)
                            .position(x: bullet.frame.midX, y: bullet.frame.minY)
                            .foregroundColor(.yellow)
                    }
                    
                    // エイリアン
                    ForEach(aliens) { alien in
                        Rectangle()
                            .frame(width: 30, height: 30)
                            .position(x: alien.frame.midX, y: alien.frame.midY)
                            .foregroundColor(.red)
                    }
                }
                .onAppear {
                    startGame()
                }
                .onChange(of: playerPosition) { _ in
                    checkCollisions()
                }
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            if !gameOver {
                                playerPosition.width = max(min(value.location.x, 300), 50)
                            }
                        }
                )
                .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()) { _ in
                    if !gameOver {
                        moveBullets()
                        moveAliens()
                    }
                }
                .onTapGesture {
                    if !gameOver {
                        shootBullet()
                    }
                }
            }
        }
    }
    
    func startGame() {
        score = 0
        gameOver = false
        playerPosition = CGSize(width: 150, height: 550)
        bullets = []
        aliens = createAliens()
    }
    
    func createAliens() -> [Alien] {
        var newAliens: [Alien] = []
        for i in 0..<5 {
            for j in 0..<5 {
                newAliens.append(Alien(id: UUID(), frame: CGRect(x: CGFloat(50 + i * 60), y: CGFloat(50 + j * 40), width: 30, height: 30)))
            }
        }
        return newAliens
    }
    
    func shootBullet() {
        let bulletFrame = CGRect(x: playerPosition.width - 2.5, y: playerPosition.height - 20, width: 5, height: 20)
        let bullet = Bullet(id: UUID(), frame: bulletFrame)
        bullets.append(bullet)
    }
    
    func moveBullets() {
        bullets = bullets.map { bullet in
            var newBullet = bullet
            newBullet.frame.origin.y -= bulletSpeed
            if newBullet.frame.origin.y < 0 {
                return Bullet(id: newBullet.id, frame: CGRect.zero) // 画面外に出た弾を削除
            }
            return newBullet
        }.filter { $0.frame != CGRect.zero }
        
        for bullet in bullets {
            for alien in aliens {
                if bullet.frame.intersects(alien.frame) {
                    score += 10
                    aliens.removeAll { $0.id == alien.id }
                    bullets.removeAll { $0.id == bullet.id }
                    break
                }
            }
        }
        
        if aliens.isEmpty {
            gameOver = true
        }
    }
    
    func moveAliens() {
        aliens = aliens.map { alien in
            var newAlien = alien
            newAlien.frame.origin.y += alienSpeed
            return newAlien
        }
        
        if aliens.contains(where: { $0.frame.minY > 600 }) {
            gameOver = true
        }
    }
    
    func checkCollisions() {
        for alien in aliens {
            if alien.frame.intersects(CGRect(x: playerPosition.width - 25, y: playerPosition.height - 10, width: 50, height: 20)) {
                gameOver = true
                break
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


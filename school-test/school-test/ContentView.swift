import SwiftUI

struct ContentView: View {
    @State private var board: [String] = Array(repeating: "", count: 9)
    @State private var isPlayerTurn = true
    @State private var winner: String? = nil
    
    var body: some View {
        VStack {
            Text(winnerMessage())
                .font(.title)
                .padding()
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 10) {
                ForEach(0..<9) { index in
                    ZStack {
                        Rectangle()
                            .foregroundColor(.blue.opacity(0.2))
                            .frame(width: 100, height: 100)
                        
                        Text(board[index])
                            .font(.largeTitle)
                            .foregroundColor(.black)
                    }
                    .onTapGesture {
                        playerMove(at: index)
                    }
                }
            }
            .padding()
            
            if winner != nil {
                Button("リセット") {
                    resetGame()
                }
                .padding()
                .font(.title)
            }
        }
    }
    
    func playerMove(at index: Int) {
        guard board[index] == "" && winner == nil else { return }
        board[index] = "O"
        isPlayerTurn = false
        
        if checkWinner(player: "O") {
            winner = "プレイヤー"
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            computerMove()
        }
    }
    
    func computerMove() {
        guard winner == nil else { return }
        let availableMoves = board.indices.filter { board[$0] == "" }
        if let move = availableMoves.randomElement() {
            board[move] = "X"
        }
        isPlayerTurn = true
        
        if checkWinner(player: "X") {
            winner = "コンピュータ"
        } else if board.allSatisfy({ $0 != "" }) {
            winner = "引き分け"
        }
    }
    
    func checkWinner(player: String) -> Bool {
        let winningPatterns: [[Int]] = [
            [0, 1, 2], [3, 4, 5], [6, 7, 8], // 横
            [0, 3, 6], [1, 4, 7], [2, 5, 8], // 縦
            [0, 4, 8], [2, 4, 6]            // 斜め
        ]
        return winningPatterns.contains { pattern in
            pattern.allSatisfy { board[$0] == player }
        }
    }
    
    func winnerMessage() -> String {
        if let winner = winner {
            return winner == "引き分け" ? "引き分けです！" : "\(winner)の勝ち！"
        } else {
            return isPlayerTurn ? "あなたのターン" : "コンピュータのターン"
        }
    }
    
    func resetGame() {
        board = Array(repeating: "", count: 9)
        isPlayerTurn = true
        winner = nil
    }
}

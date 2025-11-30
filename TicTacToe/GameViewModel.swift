import Foundation
import SwiftUI
import Combine

class GameViewModel: ObservableObject {
    
    @Published var board: [CellState] = Array(repeating: .empty, count: 9)
    @Published var currentPlayer: Player = .x
    @Published var winningCells: [Int] = []
    @Published var gameResult: String? = nil
    
    // MARK: - Haptics
    private func lightTap() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    // Player Move
    func makeMove(at index: Int) {
        guard board[index] == .empty, gameResult == nil else { return }
        
        lightTap()   // Haptic vibration
        
        board[index] = currentPlayer == .x ? .x : .o
        
        if checkForWin() {
            gameResult = "\(currentPlayer == .x ? "X" : "O") Wins🎊"
            return
        }
        
        if !board.contains(.empty) {
            gameResult = "It's a Draw!"
            return
        }
        
        currentPlayer = currentPlayer == .x ? .o : .x
    }
    
    //  Win Detection
    private func checkForWin() -> Bool {
        let winningPatterns: [[Int]] = [
            [0,1,2], [3,4,5], [6,7,8],
            [0,3,6], [1,4,7], [2,5,8],
            [0,4,8], [2,4,6]
        ]
        
        for pattern in winningPatterns {
            let first = board[pattern[0]]
            if first != .empty &&
               first == board[pattern[1]] &&
               first == board[pattern[2]] {
                
                winningCells = pattern
                return true
            }
        }
        return false
    }
    
    // Restart
    func restartGame() {
        board = Array(repeating: .empty, count: 9)
        currentPlayer = .x
        winningCells = []
        gameResult = nil
    }
}

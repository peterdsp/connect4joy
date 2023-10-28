//
//  Connect4View.swift
//  connect4joy
//
//  Created by Petros Dhespollari on 15/10/23.
//

import SwiftUI

enum Player: String {
    case red = "Player 1 (Red)"
    case yellow = "Player 2 (Yellow)"
}

struct Connect4View: View {
    @State private var board: [[Player?]] = Array(repeating: Array(repeating: nil, count: 7), count: 6)
    @State private var currentPlayer: Player = .red
    @State private var winner: Player? = nil
    
    var body: some View {
        VStack {
            Text("Current Player: \(currentPlayer.rawValue)")
                .padding()
            
            VStack {
                ForEach(0..<6, id: \.self) { row in
                    HStack {
                        ForEach(0..<7, id: \.self) { col in
                            Circle()
                                .foregroundColor(getCircleColor(for: board[row][col]))
                                .frame(width: 50, height: 50)
                                .onTapGesture {
                                    if board[row][col] == nil && winner == nil {
                                        placePiece(row: row, col: col)
                                    }
                                }
                        }
                    }
                }
            }
            .padding()
            
            if let winner = winner {
                Text("Winner: \(winner.rawValue)")
                    .padding()
                Button(action: restartGame) {
                    Text("Restart")
                }
                .padding()
            } else if checkForDraw() {
                Text("It's a draw!")
                    .padding()
                Button(action: restartGame) {
                    Text("Restart")
                }
                .padding()
            }
        }
    }
    
    private func getCircleColor(for player: Player?) -> Color {
        switch player {
        case .red:
            return .red
        case .yellow:
            return .yellow
        case .none:
            return .gray
        }
    }
    
    private func placePiece(row: Int, col: Int) {
        var updatedBoard = board
        updatedBoard[row][col] = currentPlayer
        board = updatedBoard
        
        if checkForWin(row: row, col: col) {
            winner = currentPlayer
        } else if checkForDraw() {
            winner = nil // Game is a draw
        } else {
            currentPlayer = currentPlayer == .red ? .yellow : .red
        }
    }

    private func checkForWin(row: Int, col: Int) -> Bool {
        let player = board[row][col]
        guard let currentPlayer = player else {
            return false
        }
        
        // Check horizontally
        for i in 0..<4 {
            if (col + i < 7) && (board[row][col + i] == currentPlayer) {
                var count = 0
                for j in 0..<4 {
                    if (col + j < 7) && (board[row][col + j] == currentPlayer) {
                        count += 1
                    }
                }
                if count == 4 {
                    return true
                }
            }
        }
        
        // Check vertically
        for i in 0..<4 {
            if (row + i < 6) && (board[row + i][col] == currentPlayer) {
                var count = 0
                for j in 0..<4 {
                    if (row + j < 6) && (board[row + j][col] == currentPlayer) {
                        count += 1
                    }
                }
                if count == 4 {
                    return true
                }
            }
        }
        
        // Check diagonally (top-left to bottom-right)
        for i in 0..<4 {
            if (row + i < 6) && (col + i < 7) && (board[row + i][col + i] == currentPlayer) {
                var count = 0
                for j in 0..<4 {
                    if (row + j < 6) && (col + j < 7) && (board[row + j][col + j] == currentPlayer) {
                        count += 1
                    }
                }
                if count == 4 {
                    return true
                }
            }
        }
        
        // Check diagonally (bottom-left to top-right)
        for i in 0..<4 {
            if (row - i >= 0) && (col + i < 7) && (board[row - i][col + i] == currentPlayer) {
                var count = 0
                for j in 0..<4 {
                    if (row - j >= 0) && (col + j < 7) && (board[row - j][col + j] == currentPlayer) {
                        count += 1
                    }
                }
                if count == 4 {
                    return true
                }
            }
        }
        
        return false
    }

    private func checkForDraw() -> Bool {
        for row in 0..<6 {
            for col in 0..<7 {
                if board[row][col] == nil {
                    return false
                }
            }
        }
        return true
    }

    private func restartGame() {
        board = Array(repeating: Array(repeating: nil, count: 7), count: 6)
        currentPlayer = .red
        winner = nil
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Connect4View()
    }
}

//
//  TicTacToeView.swift
//  connect4joy
//
//  Created by Petros Dhespollari on 29/10/23.
//

import SwiftUI

enum TicTacToePlayer: String {
    case x = "Player X"
    case o = "Player O"
}

struct TicTacToeView: View {
    @State private var board: [[TicTacToePlayer?]] = Array(repeating: Array(repeating: nil, count: 3), count: 3)
    @State private var currentPlayer: TicTacToePlayer = .x
    @State private var winner: TicTacToePlayer? = nil
    
    var body: some View {
        VStack {
            Text("Tic-Tac-Toe")
                .font(.largeTitle)
                .padding()
            
            Text("Current Player: \(currentPlayer.rawValue)")
                .padding()
            
            VStack {
                ForEach(0..<3, id: \.self) { row in
                    HStack {
                        ForEach(0..<3, id: \.self) { col in
                            Circle()
                                .foregroundColor(getCircleColor(for: board[row][col]))
                                .frame(width: 60, height: 60)
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
    
    private func getCircleColor(for player: TicTacToePlayer?) -> Color {
        switch player {
        case .x:
            return .blue
        case .o:
            return .green
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
            currentPlayer = (currentPlayer == .x) ? .o : .x
        }
    }
    
    private func checkForWin(row: Int, col: Int) -> Bool {
        let player = board[row][col]
        guard let currentPlayer = player else {
            return false
        }
        
        // Check horizontally
        for i in 0..<3 {
            if (col + i < 3) && (board[row][col + i] == currentPlayer) {
                var count = 0
                for j in 0..<3 {
                    if (col + j < 3) && (board[row][col + j] == currentPlayer) {
                        count += 1
                    }
                }
                if count == 3 {
                    return true
                }
            }
        }
        
        // Check vertically
        for i in 0..<3 {
            if (row + i < 3) && (board[row + i][col] == currentPlayer) {
                var count = 0
                for j in 0..<3 {
                    if (row + j < 3) && (board[row + j][col] == currentPlayer) {
                        count += 1
                    }
                }
                if count == 3 {
                    return true
                }
            }
        }
        
        // Check diagonals
        if row == col {
            var count = 0
            for i in 0..<3 {
                if (row + i < 3) && (col + i < 3) && (board[row + i][col + i] == currentPlayer) {
                    count += 1
                }
            }
            if count == 3 {
                return true
            }
        }
        
        if row + col == 2 {
            var count = 0
            for i in 0..<3 {
                if (row + i < 3) && (col - i >= 0) && (board[row + i][col - i] == currentPlayer) {
                    count += 1
                }
            }
            if count == 3 {
                return true
            }
        }
        
        return false
    }
    
    private func checkForDraw() -> Bool {
        for row in 0..<3 {
            for col in 0..<3 {
                if board[row][col] == nil {
                    return false
                }
            }
        }
        return true
    }
    
    private func restartGame() {
        board = Array(repeating: Array(repeating: nil, count: 3), count: 3)
        currentPlayer = .x
        winner = nil
    }
}

struct TicTacToeView_Previews: PreviewProvider {
    static var previews: some View {
        TicTacToeView()
    }
}

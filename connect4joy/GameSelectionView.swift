//
//  GameSelectionView.swift
//  connect4joy
//
//  Created by Petros Dhespollari on 29/10/23.
//

import SwiftUI

struct GameSelectionView: View {
    @State private var isTitleAnimated = false

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Choose a Game")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .padding(.vertical, 20))
                {
                    NavigationLink(destination: Connect4View()) {
                        Text("Connect 4")
                            .font(.title)
                            .foregroundColor(.blue)
                            .padding(.vertical, 12)
                    }
                    NavigationLink(destination: TicTacToeView()) {
                        Text("Tic-Tac-Toe")
                            .font(.title)
                            .foregroundColor(.green)
                            .padding(.vertical, 12)
                    }
                    NavigationLink(destination: GuessTheNumberView()) {
                        Text("Guess The Number")
                            .font(.title)
                            .foregroundColor(.orange)
                            .padding(.vertical, 12)
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarItems(trailing: Text("Connect4Joy").font(.system(size: 28, weight: .bold)))
        }
    }
}

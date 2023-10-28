//
//  GuessTheNumberView.swift
//  connect4joy
//
//  Created by Petros Dhespollari on 29/10/23.
//

import SwiftUI

struct GuessTheNumberView: View {
    @State private var targetNumber = Int.random(in: 1...100)
    @State private var guess = ""
    @State private var message = ""
    @State private var isGameWon = false

    var body: some View {
        VStack {
            Text("Guess the Number")
                .font(.largeTitle)
                .padding()

            Text("I'm thinking of a number between 1 and 100.")
                .padding()

            TextField("Your Guess", text: $guess)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
                .padding()

            Button("Submit Guess") {
                checkGuess()
            }
            .padding()

            Text(message)
                .padding()

            if isGameWon {
                Button("Play Again") {
                    restartGame()
                }
                .padding()
            }
        }
    }

    func checkGuess() {
        if let userGuess = Int(guess) {
            if userGuess == targetNumber {
                message = "Congratulations! You guessed the number."
                isGameWon = true
            } else if userGuess < targetNumber {
                message = "Try a higher number."
            } else {
                message = "Try a lower number."
            }
        } else {
            message = "Please enter a valid number between 1 and 100."
        }
    }

    func restartGame() {
        targetNumber = Int.random(in: 1...100)
        guess = ""
        message = ""
        isGameWon = false
    }
}

struct GuessTheNumberView_Previews: PreviewProvider {
    static var previews: some View {
        GuessTheNumberView()
    }
}

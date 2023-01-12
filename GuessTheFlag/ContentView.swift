//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Putut Yusri Bahtiar on 06/01/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var question = 8
    
    @State private var countries = ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var wrongAnswer = Int.random(in: 0...2)

    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack(spacing: 30) {
                VStack {
                    Text("Tebak Bendera Negara")
                        .foregroundColor(.white)
                        .font(.subheadline.weight(.heavy))
                    Text(countries[correctAnswer].uppercased())
                        .foregroundColor(.white)
                        .font(.largeTitle.weight(.semibold))
                }
                ForEach(0..<3) {number in
                    Button {
                        flagTapped(number)
                    } label: {
                        Image(countries[number])
                            .renderingMode(.original)
                            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                            .shadow(radius: 5)
                    }
                }
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.largeTitle.weight(.bold))
            }
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: askQuestion)
                Button("Reset", action: askQuestion)
            } message: {
                Text("Your Score is \(score)")
            }
        }
}
func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct +10"
            score += 10
        } else {
            scoreTitle = "Wrong -10 that flag of \(countries[number].uppercased())"
            score -= 10
        }
    if question == 8 {
        scoreTitle = "Game Over! your final score\(score)"
            .uppercased()
        showingScore = true
    } else {
        showingScore = true
        question += 1
    }
    }
    
    func askQuestion() {
                countries.shuffle()
                correctAnswer = Int.random(in: 0...2)
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

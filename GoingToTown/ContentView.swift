//
//  ContentView.swift
//  GoingToTown
//
//  Created by Caden Christesen on 12/4/23.
//

import SwiftUI

struct ContentView: View {
    @State private var turnScore = 0
    @State private var PlayerOneScore = 0
    @State private var PlayerTwoScore = 0
    @State private var winningScore = 0
    @State private var round = 1
    @State private var gameOver = false
    @State private var currentPlayer = 1
    @State private var winningPlayer = 1
    @State private var rollsRemaining = 3
    @State private var rotation = 0.0
    
    @State private var diceValues: [Int] = [0, 0, 0]
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    Text("Player \(currentPlayer) Turn")
                        .font(Font.custom("Verdana Bold", size: 24))
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    CustomText(text: "Going to Boston")
                        .font(Font.custom("Verdana Bold", size: 24))
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    Text("Round: \(round)")
                        .font(Font.custom("Verdana Bold", size: 24))
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    Spacer()
                    HStack {
                        ForEach(0..<3) { index in
                            Image("pips \(diceValues[index])")
                                .resizable()
                                .frame(width: 75, height: 75)
                                .rotationEffect(.degrees(rotation))
                                .rotation3DEffect(.degrees(rotation), axis: (x: 1, y: 1, z: 0))
                                .padding(10)
                        }
                    }
                    Text("Total: \(turnScore)")
                        .font(Font.custom("Verdana Bold", size: 24))
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    HStack{
                        Text("P1 Total: \(PlayerOneScore)")
                            .font(Font.custom("Verdana Bold", size: 20))
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        Text("P2 Total: \(PlayerTwoScore)")
                            .font(Font.custom("Verdana Bold", size: 20))
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    Spacer()
                    Button("Roll") {
                        rollDice()
                        withAnimation(.interpolatingSpring(stiffness: 10, damping: 2)) {
                            rotation += 360
                        }
                    }
                    .buttonStyle(CustomButtonStyle())
                    Button("End Turn") {
                        endTurn()
                    }
                    .frame(width: 100)
                    .font(Font.custom("Verdana", size: 20))
                    .padding()
                    .background(.red)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                Spacer()
                }
            }
            .alert(isPresented: $gameOver, content: {
                Alert(title: Text("Player \(winningPlayer) won the round!"),
                      message: Text("Total Score: \(winningScore)"),
                      dismissButton:
                        .destructive(Text("Next Game"), action: {
                            if PlayerOneScore > PlayerTwoScore{
                                winningPlayer = 1
                                winningScore = PlayerOneScore
                            }
                            else if PlayerOneScore < PlayerTwoScore{
                                winningPlayer = 2
                                winningScore = PlayerTwoScore
                            }
                            else{
                                winningPlayer = 3
                            }
                            if round <= maxRounds {
                                currentPlayer = 1
                                gameOver = false
                            } else {
                                round = 1
                                endGame()
                            }
                            PlayerOneScore = 0
                            PlayerTwoScore = 0
                            winningScore = 0
                            winningScore = 0
                        }))
            })
        }
    }
    func rollDice() {
        guard rollsRemaining > 0 else {
            return
        }
        
        diceValues = [Int.random(in: 1...6), Int.random(in: 1...6), Int.random(in: 1...6)]
        
        // On the first two rolls, keep the highest value
        let maxDiceValue = diceValues.max() ?? 0
        if rollsRemaining == 3 || rollsRemaining == 2 {
            turnScore += maxDiceValue
        }
        
        rollsRemaining -= 1
        
        // On the last roll, add up all three dice values
        
        //set so it shows all 3 rolls combined before simply switching turns
        //done
        
        if rollsRemaining == 0 {
            turnScore += maxDiceValue
        }
    }
    
    func endTurn() {
        if currentPlayer == 1 {
            PlayerOneScore += turnScore
            currentPlayer = 2
        }
        else if currentPlayer == 2 {
            PlayerTwoScore += turnScore
            startNextRound()
        }
        turnScore = 0
        rollsRemaining = 3
        diceValues = [0, 0, 0]
    }
    
    func startNextRound() {
        if PlayerOneScore > PlayerTwoScore{
            winningPlayer = 1
            winningScore = PlayerOneScore
        }
        else if PlayerOneScore < PlayerTwoScore{
            winningPlayer = 2
            winningScore = PlayerTwoScore
        }
        
        //add alert case for tie
        
        else{
            winningPlayer = 3
        }
        
        round += 1
        if round <= maxRounds {
            currentPlayer = 1
            gameOver = false
        } else {
            round = 1
            endGame()
        }
    }
    
    func checkGameOver() {
        if round > maxRounds {
            endGame()
        }
    }
    
    func endGame() {
        gameOver = true
    }
    
    let maxRounds = 3
}
struct CustomText: View{
    let text: String
    var body: some View{
        Text(text).font(Font.custom("Verdana Bold", size: 36))
    }
}
struct CustomButtonStyle: ButtonStyle{
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 100)
            .font(Font.custom("Verdana Bold", size: 24))
            .padding()
            .background(.red).opacity(configuration.isPressed ? 0.0 : 1.0)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

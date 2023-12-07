//
//  ContentView.swift
//  GoingToTown
//
//  Created by Caden Christesen on 12/4/23.
//

import SwiftUI

struct ContentView: View {
    @State private var turnScore = 0
    @State private var gameScore = 0
    @State private var round = 1
    @State private var gameOver = false
    @State private var currentPlayer = 1
    @State private var rollsRemaining = 3
    @State private var rotation = 0.0  // Added rotation variable
    
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
                    HStack {
                        Text("Player \(currentPlayer) Turn")
                            .font(Font.custom("Verdana Bold", size: 24))
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    Spacer()
                    CustomText(text: "Going to Boston")
                        .background(Color.white)
                    Spacer()
                    CustomText(text: "Round: \(round)")
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
                    Spacer()
                    CustomText(text: "Total: \(turnScore)")
                        .background(Color.white)
                    
                    Button("Roll") {
                        rollDice()
                        withAnimation(.interpolatingSpring(stiffness: 10, damping: 2)) {
                            rotation += 360
                        }
                    }
                    .buttonStyle(CustomButtonStyle())
                    Spacer()
                    Button("End Turn") {
                        endTurn()
                        
                    }
                    .background(Color.red)
                    .font(Font.custom("Verdana Bold", size: 24))
                    .foregroundStyle(.white)
                    Spacer()
                }
            }
            .alert(isPresented: $gameOver, content: {
                Alert(title: Text("Player \(currentPlayer) won the round!"),
                      message: Text("Total Score: \(gameScore)"),
                      dismissButton:
                        .destructive(Text("Next Round"), action: {
                            startNextRound()
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
            //let maxDiceValue = diceValues.max() ?? 0
            turnScore += maxDiceValue
        }
        
        rollsRemaining -= 1
        
        // On the last roll, add up all three dice values
        
        //set so it shows all 3 rolls combined before simply switching turns
        //done
        
        if rollsRemaining == 0 {
            turnScore += maxDiceValue
            
            //turnScore += diceValues.reduce(0, +)
            //endTurn()
        }
    }
    
    func endTurn() {
        gameScore += turnScore
        if currentPlayer == 1 {
            currentPlayer = 2
        }
        else if currentPlayer == 2 {
            startNextRound()
        }
        //else {
          //  round += 1
            //checkGameOver()
        //}
        
        turnScore = 0
        rollsRemaining = 3
        diceValues = [0, 0, 0]
    }
    
    func startNextRound() {
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
            .frame(width: 50)
            .font(Font.custom("Marker Felt", size: 24))
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

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
    @State private var randomValue = 0
    @State private var rotation = 0.0
    @State private var gameOver = false
    var body: some View {
        NavigationView{
            ZStack{
                Color.gray.opacity(0.7).ignoresSafeArea()
                VStack{
                    Image("Pig").resizable().frame(width: 150, height: 150)
                    CustomText(text: "Pig")
                    
                    HStack{
                        Image("pips \(randomValue)")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .rotationEffect(.degrees(rotation))
                            .rotation3DEffect(.degrees(rotation), axis: (x: 1, y: 1, z: 0))
                            .padding(50)
                        Image("pips \(randomValue)")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .rotationEffect(.degrees(rotation))
                            .rotation3DEffect(.degrees(rotation), axis: (x: 1, y: 1, z: 0))
                            .padding(50)
                        
                        Image("pips \(randomValue)")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .rotationEffect(.degrees(rotation))
                            .rotation3DEffect(.degrees(rotation), axis: (x: 1, y: 1, z: 0))
                            .padding(50)
                        
                    }
                    CustomText(text: "Turn Score: \(turnScore)")
                    HStack{
                        Button("Roll"){
                            chooseRandom(times: 3)
                            withAnimation(.interpolatingSpring(stiffness: 10, damping: 2)) {
                                rotation += 360
                            }
                        }
                        .buttonStyle(CustomButtonStyle())
                        Button("Hold"){
                            gameScore += turnScore
                            endTurn()
                            withAnimation(.easeInOut(duration: 1)) {
                                rotation += 360
                                if gameScore >= 100 {
                                    gameOver = true
                                }
                            }
                        }
                        .buttonStyle(CustomButtonStyle())
                    }
                    CustomText(text: "Game Score: \(gameScore)")
                    Button ("Reset") {
                        endTurn()
                        gameScore = 0
                    }
                    .font(Font.custom ( "Marker Felt", size: 24))
                    Spacer()
                }
            }
            .alert(isPresented: $gameOver, content: {
                Alert(title: Text ("You won the game!"), dismissButton:
                        .destructive(Text ("Play again"), action: {
                    withAnimation(Animation.default){
                        gameScore = 0
                        gameOver = false
                    }
                }))
            })
        }
    }
    func endTurn(){
        turnScore = 0
        randomValue = 0
    }
    func chooseRandom(times: Int){
        if times > 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                randomValue = Int.random(in:1...6)
                chooseRandom(times: times - 1)
            }
        }
        if times == 0{
            if randomValue == 1{
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    endTurn()
                }
                
            }
            else{
                turnScore += randomValue
            }
        }
    }
}
struct CustomText: View{
    let text: String
    var body: some View{
        Text(text).font(Font.custom("Marker Felt", size: 36))
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

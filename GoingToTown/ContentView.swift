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
    @State private var randomValue0 = 0
    @State private var randomValue1 = 0
    @State private var randomValue2 = 0
    @State private var rotation = 0.0
    @State private var gameOver = false
    var body: some View {
        NavigationView{
            ZStack{
                Image("background")
                                .resizable()
                                .scaledToFill()
                                .edgesIgnoringSafeArea(.all)
                //Color.gray.opacity(0.7).ignoresSafeArea()
                
                VStack{
                    Spacer()
                    CustomText(text: "Going to Town")
                        .background(Color.white)
                    Spacer()
                    HStack{
                        Image("pips \(randomValue0)")
                            .resizable()
                            .frame(width: 75, height: 75)
                            .rotationEffect(.degrees(rotation))
                            .rotation3DEffect(.degrees(rotation), axis: (x: 1, y: 1, z: 0))
                            .padding(10)
                        Image("pips \(randomValue1)")
                            .resizable()
                            .frame(width: 75, height: 75)
                            .rotationEffect(.degrees(rotation))
                            .rotation3DEffect(.degrees(rotation), axis: (x: 1, y: 1, z: 0))
                            .padding(10)
                        
                        Image("pips \(randomValue2)")
                            .resizable()
                            .frame(width: 75, height: 75)
                            .rotationEffect(.degrees(rotation))
                            .rotation3DEffect(.degrees(rotation), axis: (x: 1, y: 1, z: 0))
                            .padding(10)
                        
                    }
                    Spacer()
                    CustomText(text: "Turn Score: \(turnScore)")
                        .background(Color.white)
                    
                        Button("Roll"){
                            chooseRandom(times: 3)
                            withAnimation(.interpolatingSpring(stiffness: 10, damping: 2)) {
                                rotation += 360
                            }
                        }
                        .buttonStyle(CustomButtonStyle())
                    Spacer()
                    Button ("Reset") {
                        endTurn()
                        gameScore = 0
                    }
                    .background(Color.white)
                    .font(Font.custom ( "Verdana", size: 24))
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
        randomValue0 = 0
        randomValue1 = 0
        randomValue2 = 0
    }
    func chooseRandom(times: Int){
        if times > 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                randomValue0 = Int.random(in:1...6)
                randomValue1 = Int.random(in:1...6)
                randomValue2 = Int.random(in:1...6)
                chooseRandom(times: times - 1)
            }
        }
        if times == 0{
                turnScore += (randomValue0 + randomValue1 + randomValue2)
        }
    }
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

//
//  HomeScreen.swift
//  GoingToTown
//
//  Created by Caden Christesen on 12/8/23.
//

import SwiftUI

struct HomeScreen: View {
    var body: some View {
        NavigationView{
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    Text("Going to Boston")
                        .font(Font.custom("Verdana Bold", size: 36))
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    NavigationLink ( "Play Game", destination: ContentView())
                        .font(Font.custom("Verdana Bold", size: 24))
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    NavigationLink ( "How to Play", destination: InstructionsView())
                        .font(Font.custom("Verdana Bold", size: 24))
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
        }
    }
}
struct InstructionsView: View {
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("How To Get to Boston")
                    .font(Font.custom("Verdana Bold", size: 24))
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                VStack (alignment: .leading) {
                    
                    Text("How to play:")
                        .font(Font.custom("Verdana Bold", size: 12))
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white)
                    Spacer()
                    Text("Each player in turn has three throws of the dice.")
                        .font(Font.custom("Verdana", size: 12))
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    Spacer()
                    Text("On the first throw, the highest number is put to one side. If two or more of the dice show the highest number, only one is kept.")
                        .font(Font.custom("Verdana", size: 12))
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    Spacer()
                    Text("The remaining two dice are thrown and once again the highest-numbered dice are put aside. ")
                        .font(Font.custom("Verdana", size: 12))
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    Spacer()
                    Text("The final dice is then rolled and the total of all three dice is the player’s score.")
                        .font(Font.custom("Verdana", size: 12))
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    Spacer()
                    Text("How do you win the game?")
                        .font(Font.custom("Verdana Bold", size: 12))
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    Spacer()
                    Text("When all players have had a turn, the player with the highest overall score wins the game. ")
                        .font(Font.custom("Verdana", size: 12))
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

#Preview {
    HomeScreen()
}

//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Дарья on 02.01.2021.
//  Copyright © 2021 Дарья. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Argentina", "Bangladesh", "Brazil", "Canada", "Germany", "Greece", "Russia", "Sweden", "UK", "USA"].shuffled()
    @State private var rightAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var shoingScore = false
    @State private var scoreTitle = ""
    
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.black, .white]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 10) {
                Text("Выберите флаг")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
                Text("\(countries[rightAnswer])")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                VStack (spacing: 30){
                    ForEach(0..<3){ index in
                        Button(action: {
                            self.flagTapped(index)
                            self.shoingScore = true
                        }) {
                            Image(self.countries[index])
                                .renderingMode(.original)
                                .frame(width: 250, height: 130)
                                .clipShape(Capsule())
                                .overlay(Capsule().stroke(Color.black, lineWidth: 2))
                                .shadow(color: .black, radius: 2)
                        }
                    }
                }
                Text("Общий счет: \(score)")
                    .font(.largeTitle)
                    .padding()
                Spacer()
            }
        } .alert(isPresented: $shoingScore) { () -> Alert in
            Alert(title: Text(scoreTitle), message: Text("Общий счет \(score)"), dismissButton: .default(Text("Продолжить")){
                    self.upload()
                })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == rightAnswer {
            score += 1
            scoreTitle = "Правильно!"
        } else {
            score -= 1
            scoreTitle = "Неправильно. Это флаг \(countries[number])"
        }
    }
    
    func upload() {
        countries = countries.shuffled()
        rightAnswer = Int.random(in: 0...2)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

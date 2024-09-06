//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Adailton Lucas on 05/09/24.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var answerAlertShow = false
    @State private var answerMessage = ""
    
    @State private var correctScore = 0
    @State private var incorrectScore = 0
    
    @State private var round = 1
    
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.2), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
        
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                VStack(spacing: 15) {
                    VStack{
                        Text("Qual é a bandeira do País?")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.bold))
                        
                        Text(countries[correctAnswer])
                            .foregroundStyle(.primary)
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3){ number in
                        Button{
                            flagPressed(number)
                        } label : {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 10)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Pontuação: \(correctScore)")
                    .font(.title.bold())
                    .foregroundStyle(.white)
                
                Spacer()
            }
            .padding()
        }.alert(answerMessage, isPresented: $answerAlertShow){
            if(round < 8){
                Button("Continuar", role: .cancel) {
                    shuffle()
                }
            }
            Button("Reiniciar", role: round < 8 ? .destructive : .cancel) {
                reset()
            }
        } message: {
                Text("Acertos: \(correctScore) \n Erros: \(incorrectScore)")
        }
    }
    
    func flagPressed (_ number : Int){
            if(number == correctAnswer){
                answerMessage = "Certa resposta"
                correctScore += 1
            } else {
                answerMessage = "Resposta incorreta"
                incorrectScore += 1
            }
        
        if round == 8 {
            answerMessage = "Pontuação final:"
        }
        
        answerAlertShow = true
    }
    
    func shuffle(){
        round += 1
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func reset(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        correctScore = 0
        incorrectScore = 0
        round = 1
    }
}

#Preview {
    ContentView()
}

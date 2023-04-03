//
//  ContentView.swift
//  Swiftui_intro
//
//  Created by David Salmberg on 2023-04-03.
//

import SwiftUI

struct ContentView: View {
   @State var diceNumber1 = 3
   @State var diceNumber2 = 3
   @State var sum = 0
   @State var showingBustSheet = false
    

    
    var body: some View {
        
        ZStack{
            Color(red: 38/256, green: 108/256, blue: 59/256)
                .ignoresSafeArea()
            
            
            VStack {
                Text("\(sum)")
                    .font(.title)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                Spacer()
                
                HStack{
                    DiceView(n: diceNumber1)
                    DiceView(n: diceNumber2)
                }.onAppear() {
                    newDiceValue()
                }
                Button(action: {
                    //roll Dice
                    rollDice()
                }, label: {
                    Text("Roll")
                        .font(.largeTitle)
                        .padding()
                        .foregroundColor(Color.white)
                })
                .background(Color.red)
                .cornerRadius(15.0)
                Spacer()
            }
        }
        .sheet(isPresented: $showingBustSheet,onDismiss: {sum = 0},content: {
            BustSheet(sum: sum)
        })
    }
    
    func newDiceValue(){
        diceNumber1 = Int.random(in: 1...6)
        diceNumber2 = Int.random(in: 1...6)
    }
    
    func rollDice() {
        newDiceValue()
        
        sum += diceNumber1 + diceNumber2
        if (sum > 21) {
            showingBustSheet = true
        }
    }
    
    struct DiceView : View {
        
        let n : Int
        var body: some View{
            Image(systemName: "die.face.\(n)")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
        }
    }
    
    struct BustSheet : View {
        let sum : Int
        
        var body: some View {
            ZStack{
                Color(red: 38/256, green: 108/256, blue: 59/256)
                    .ignoresSafeArea()
                VStack {
                    Text("Bust!")
                        .foregroundColor(.white)
                        .font(.title)
                    Text("\(sum)")
                        .foregroundColor(.red)
                        .font(.title)
                }
                
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
   
}

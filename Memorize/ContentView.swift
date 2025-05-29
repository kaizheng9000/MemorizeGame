//
//  ContentView.swift
//  Memorize
//
//  Created by Kai Zheng on 5/28/25.
//

import SwiftUI

struct ContentView: View {
    let halloweenEmojis = ["👻", "👻", "🎃", "🎃", "🧛🏻", "🧛🏻","😈", "😈","💀", "💀","🧙🏻‍♂️","🧙🏻‍♂️", "🦁", "👺"]
    let christmasEmojis = ["❄️", "☃️", "☃️", "🎄", "🎁", "🎅", "🎇", "🎇","🎊", "🎊","🎉", "🎉"]
    let defaultEmojis = ["😊","😊", "😏", "😏", "😎", "😘", "😘", "😱", "😱", "😨", "😨", "😰", "😮"]
    
    var themes = ["Halloween", "Christmas", "Default"]
    
    
    @State var currentTheme: [String] = ["😊","😊", "😏", "😏", "😎", "😘", "😘", "😱", "😱", "😨", "😨", "😰", "😮"].shuffled()
    
    @State var cardColor = Color.orange
    
    var body: some View {
        VStack{
            Text("Memorize!")
                .font(.largeTitle)
            cards
            Spacer()
            themePicker
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum:60))]){
            ForEach(0..<currentTheme.count, id: \.self){ index in
                CardView(content: currentTheme[index])
                    .aspectRatio(3/5, contentMode: .fit)
            }
        }
        .foregroundColor(cardColor)
    }
    
    var themePicker: some View {
        HStack(alignment: .bottom) {
            ForEach(0..<themes.count, id: \.self) { index in
                VStack {
                    themeButton(by: themes[index])
                    Text(themes[index])
                        .frame(maxWidth: .infinity)
                        .font(.caption)
                }
                
            }
        }
    }
    
    func themeButton(by theme: String) -> some View {
        Button(action: {
            switch theme{
                case "Halloween":
                    currentTheme = halloweenEmojis.shuffled()
                    cardColor = Color.orange
                    break;
                case "Christmas":
                    currentTheme = christmasEmojis.shuffled()
                    cardColor = Color.green
                    break;
                default:
                    currentTheme = defaultEmojis.shuffled()
                    cardColor = Color.blue
            }
        }, label: {
            Image(systemName: theme == "Halloween" ?  "theatermasks" : theme == "Christmas" ? "snowflake" : "face.smiling")
                .imageScale(.large)
        })
    }

}

struct CardView: View {
    let content: String
    @State var isFaceUp = false // Temporary state
    
    var body: some View{
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0: 1)
                
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}

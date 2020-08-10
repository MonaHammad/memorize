//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Mona Hammad on 7/9/20.
//  Copyright © 2020 Mona Hammad. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Grid(viewModel.cards) { card in
                   CardView(card: card).onTapGesture {
                    withAnimation(.linear(duration: 0.75)) {
                        self.viewModel.choose(card: card)
                    }
            }
        .padding(5)
    }
.padding()
    .foregroundColor(Color.orange)
            Button(action: {
                withAnimation(.easeInOut(duration : 2)) {
                    self.viewModel.resetGame()
                }
            }, label: { Text("new Game")})
        .font(Font.largeTitle)
    }
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geomtry in
            self.body(for: geomtry.size
            )
        }
    }
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bounsRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
             ZStack {
                Group {
                if card.isConsumingBonusTime {
                    Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining*360 - 90),clockwise: true)
                        .onAppear() {
                            self.startBonusTimeAnimation()
                    }
                } else {
                    Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-card.bounsRemaining*360 - 90),clockwise: true)

                    } }.padding(5).opacity(0.4)
                .transition(.identity)
                
                Text(self.card.content)        .font(Font.system(size:fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 180 : 0)).animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false): .default)

                   }
                   .cardify(isFaceUP: card.isFaceUp)
             .transition(AnyTransition.scale)
             .rotation3DEffect(Angle.degrees(card.isFaceUp ? 0 : 180), axis: (0,1,0))
        }
        
    }
    // MARK: - Drawing Constants
    
 
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width,size.height) * 0.7
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}

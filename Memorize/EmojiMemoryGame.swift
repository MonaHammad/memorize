//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Mona Hammad on 7/13/20.
//  Copyright © 2020 Mona Hammad. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    private static func createMemoryGame() -> MemoryGame<String> {
        let emojis = ["👻", "🎃", "🕷"]
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) { pairIndex in
        return emojis[pairIndex]
        }
    }
    
    // MARK: - Acess to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
         model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func resetGame() {
        model = EmojiMemoryGame.createMemoryGame()
    }
}


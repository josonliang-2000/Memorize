//
//  EmojiMemoryGame.swift
//  Memorize
//  View-Model
//  Created by joson on 2024/11/24.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private static let emojis = ["😅", "😄", "🥰", "😎", "😗", "😡", "🥵", "🫵", "😍", "🍐", "🍊", "🍋", "🍌", "🌽", "🍑", "🍎"]
    @Published private var model = createMemoryGame()
    
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame(numberOfPairsCards: 16){ pairIndex in
            if (emojis.indices.contains(pairIndex)) {
                return emojis[pairIndex]
            } else {
                return "🕹️"
            }
        }
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: -Intents
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
 

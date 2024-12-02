//
//  MemorizeGame.swift
//  Memorize
//  Model
//  Created by joson on 2024/11/24.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    init(numberOfPairsCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        // add numberOfPairsOfCards x 2 cards
        for pairIndex in 0..<max(2, numberOfPairsCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {cards.indices.filter{ cards[$0].isFaceUp }.only}        
        set {cards.indices.forEach{ cards[$0].isFaceUp = (newValue == $0) }}
    }
    
    mutating func choose(_ card: Card) {
       print("chose \(card)")
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}) {
            // 定位到tap到的那张卡片
            if !cards[chosenIndex].isMatched && !cards[chosenIndex].isFaceUp {
                // 如果tap卡片是反面，并且是未匹配过的，则进一步处理
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if (cards[chosenIndex].content == cards[potentialMatchIndex].content) {
                        cards[chosenIndex].isMatched = true;
                        cards[potentialMatchIndex].isMatched = true;
                    }
                } else {
                    // 没有待匹配的
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true;
            }
        }
    }
    
//    private func index(of card: Card) -> Int? {
//        for index in cards.indices {
//            if (cards[index].id == card.id) {
//                return index
//            }
//        }
//        return nil // FIXME: bogus!
//    }
    
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        
        var id: String
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "up" : "down")\(isMatched ? " matched" : "") "
        }
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}

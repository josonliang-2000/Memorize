//
//  ContentView.swift
//  Memorize
//  View
//  Created by joson on 2024/11/22.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var ViewModel: EmojiMemoryGame // 实例在更高层的MemorizeApp中创建
    var body: some View {
        VStack { 
            ScrollView {
                cards
                    // `.default` 使用的是系统默认的动画类型，通常是平滑过渡的动画效果。
                    .animation(.default, value: ViewModel.cards)
            }
                .padding()
            Button("shuffle") {
                ViewModel.shuffle()
            }
        }

    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 90), spacing: 0)], spacing: 0) {
            ForEach(ViewModel.cards) { card in // 这里遍历card本身而不是索引数组indices
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        ViewModel.choose(card)
                    }
            }
        }
        .foregroundColor(Color.orange)
    }
    
//    var cardCountAdjuster: some View {
//        HStack {
//            cardRemover
//            Spacer()
//            cardAdder
//
//        }
//        .imageScale(.large)
//        .font(.largeTitle)
//    }
    
//    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
//        Button(action: {
//            cardCount += offset
//        }, label: {
//            Image(systemName: symbol)
//        })
//        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
//    }
//    
//    var cardRemover: some View {
//        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
//    }
//    
//    var cardAdder: some View {
//        cardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")
//    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack(alignment: .center){
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
                .opacity(card.isFaceUp ? 1 : 0) // 为true时显示圆形边框和文字
            base.fill()
                .opacity(card.isFaceUp ? 0 : 1) // 为true时隐藏圆形填充
        }
        .opacity(!card.isMatched ? 1 : 0)
    }
}


#Preview {
    EmojiMemoryGameView(ViewModel: EmojiMemoryGame())
}


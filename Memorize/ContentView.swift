//
//  ContentView.swift
//  Memorize
//
//  Created by joson on 2024/11/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        let emojis: [String] = ["😅", "😅", "😃", "😄", "🥰"]
        HStack {
            ForEach(emojis.indices, id:\.self) { index in
                CardView(content: emojis[index])
            }
        }
        .foregroundColor(.orange)
        .padding()
    }}

struct CardView: View {
    let content: String
    @State var isFaceup: Bool = true
    var body: some View {
        ZStack(alignment: .center){
            let base = Circle()
            if (isFaceup) {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            } else {
                base.fill()
            }
        }
        .onTapGesture{
            isFaceup.toggle()
        }
    }
}


#Preview {
    ContentView()
}


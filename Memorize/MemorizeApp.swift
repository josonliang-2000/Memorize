//
//  MemorizeApp.swift
//  Memorize
//
//  Created by joson on 2024/11/22.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var game = EmojiMemoryGame() // ViewModel实例在这里创建
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(ViewModel: game) // 将实例注入视图View
            // hello
        }
    }
}

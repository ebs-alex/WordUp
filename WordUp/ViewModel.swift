//
//  ViewModel.swift
//  WordUp
//
//  Created by Alex Moran on 10/25/23.
//

import Foundation
import SwiftUI

@MainActor class ViewModel: ObservableObject {
    
    let words: [Word] = Bundle.main.decode("words.json")
    @Published var currentExamWord: Word
    var randomWord: Int
    var options = [String]()
    
    
    
    init() {
        self.randomWord = Int.random(in: 0...words.count-1)
        self.currentExamWord = words[randomWord]
        self.options = generateOptions()
    }
    
    
    func generateOptions() -> [String] {
        
        var options = [String]()
        
        let answer = currentExamWord.answer
        var wrong1: String;
        var wrong2: String;
        var wrong3: String;
        
        options.append(answer)
        
        repeat {
            let randomIndex = Int.random(in: 0...words.count-1)
            wrong1 = words[randomIndex].answer
        } while wrong1 == answer
        options.append(wrong1)
        
        repeat {
            let randomIndex = Int.random(in: 0...words.count-1)
            wrong2 = words[randomIndex].answer
        } while options.contains(wrong2)
        options.append(wrong2)
        
        
        repeat {
            let randomIndex = Int.random(in: 0...words.count-1)
            wrong3 = words[randomIndex].answer
        } while options.contains(wrong3)
        options.append(wrong3)
        
        return options.shuffled()
    }
    
    
    

    func nextWord() {
        self.randomWord = Int.random(in: 0...words.count-1)
        self.currentExamWord = words[randomWord]
//        reset()
        recordScore()
        options = generateOptions()
    }
    
    
//    func reset() {
//        useSentenceShowing = false
//        synonymsShowing = false
//        definitionShowing = false
//        stage = 0
//        resultMessage = ""
//        selectionsEnabled = true
//    }
    
    func recordScore() {
        
    }
    
}



struct BlueButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(15)
            .background(Color(red: 0, green: 0, blue: 0.5))
            .foregroundStyle(.white)
            .clipShape(Capsule())
    }
}

struct TitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .padding(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.blue, lineWidth: 2)
            )
    }
}

extension Text {
    func textAsButton() -> some View {
        self.bold().lineLimit(4)
            .modifier(TitleModifier())
    }
}

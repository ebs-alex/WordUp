//
//  ViewModel.swift
//  WordUp
//
//  Created by Alex Moran on 10/25/23.
//

import Foundation
import SwiftUI

@MainActor class ExamModel: ObservableObject {
    
    enum roundResults {
        case won, lost, neutral
    }
    
    var words: [Word] = Bundle.main.decode("words.json")
    var usedWords = [Word]()
    @Published var currentExamWord: Word
    var wordIndex = 0
    var options = [String]()
    var earnablePoints: Int = 0
    var roundResult: roundResults = .neutral
    var helpCount = 0
    
    
    init() {
//        self.wordIndex = Int.random(in: 0...words.count-1)
        self.words = words.shuffled()
        self.currentExamWord = words[wordIndex]
        self.options = generateOptions()
        self.earnablePoints = calcEarnablePoints()
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
    
    
    func calcEarnablePoints() -> Int {
        
        return currentExamWord.level * 3
    }
    

    func nextWord() {

        
        if roundResult == .won {
            if let index = words.firstIndex(of: currentExamWord) {
                print("------")
                print(words[0].name)
                print("------")
                
                
                words.remove(at: index)
                words.append(currentExamWord)
                
                
            }
        } else {
            if let index = words.firstIndex(of: currentExamWord) {
                print("~~~~~~~")
                print(words[0].name)
                print("~~~~~~~")
                
                words.remove(at: index)
                let newIndex = Int(floor(Double(words.count / 2)))
                words.insert(currentExamWord, at: newIndex)
                
            }
        }
        
        currentExamWord = words[wordIndex]
        
        options = generateOptions()
        
        earnablePoints = calcEarnablePoints()
        
        roundResult = .neutral
        
        helpCount = 0
        
        for (index, word) in words.enumerated() {
            print("\(word.name)...\(index)")
        }
        
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
            .frame(width: 200, height: 80)
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
    
    func optionStyle() -> some View {
        self.bold().lineLimit(4)
            .font(.title2)
            .frame(width: 150, height: 80)
            .padding(5)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.blue, lineWidth: 2)
            )
    }
        
}

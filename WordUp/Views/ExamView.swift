//
//  ExamView.swift
//  WordUp
//
//  Created by Alex Moran on 10/28/23.
//

import SwiftUI

struct ExamView: View {
    let word: Word
    
    var options: [String] {
        [word.answer, "wrong answer1", "wrong answer2", "wrong answer3"]
    }
    
    private let twoGrid: [GridItem] = [
        .init(.flexible(), spacing: 2),
        .init(.flexible(), spacing: 2),
    ]
    
    @State private var stage = 0
    
    @State private var definitionOpacity = 0.0
    @State private var definitionShowing = false
    
    @State private var useSentenceOpacity = 0.0
    @State private var useSentenceShowing = false
    
    @State private var synonymsOpacity = 0.0
    @State private var synonymsShowing = false
    
    @State private var resultMessage = ""
    @State private var selectionsEnabled = true
    
    var body: some View {
        VStack {
            Text(word.name)
                .font(.largeTitle)
                .padding(.vertical)
            HStack {
                Text("\"\(word.phonetics)\"")
                    .font(.headline)
                    .padding(.horizontal)
                Spacer()
            }
            HStack {
                Text(word.partOfSpeech)
                    .font(.title2)
                    .padding(.horizontal)
                    .bold()
                Spacer()
                Text("Level \(word.level)")
                    .font(.title2)
                    .padding(.horizontal)
                    .bold()
            }
            
            LazyVGrid(columns: twoGrid, spacing: 2) {
                ForEach(options, id: \.self) { option in
                    Button {
                        selectionMade(option)
                    } label: {
                        Text(option)
                            .font(.subheadline)
                            .foregroundStyle(.white)
                            .textAsButton()
                            .padding(.vertical)
                            .frame(width: 150)
                    }
                }
                .allowsHitTesting(selectionsEnabled)
            }
            .padding(.bottom,5)
            Text(resultMessage)
                .padding(.bottom,5)
                .font(.title)
                .foregroundStyle(resultMessage == "CORRECT!" ? .green : .red)
            Text(word.fullDefinition)
                .bold()
                .font(.title3)
                .opacity(definitionShowing ? 1.0 : 0.0 )
                .padding(.horizontal)
            Spacer()
            Text("\" \(word.useSentence) \"")
                .opacity(useSentenceShowing ? 1.0 : 0.0 )
            Spacer()
            
            Group {
                Text("Synonyms")
                    .underline()
                LazyVGrid(columns: twoGrid, spacing: 5) {
                    ForEach(word.synonyms, id: \.self) { syn in
                        Text(syn)
                    }
                }
            }
            .opacity(synonymsShowing ? 1.0 : 0.0)
            .font(.headline)
            Spacer()
            
            VStack(spacing: 25) {
                if stage == 0 {
                    Button("Use in Sentence") {
                        withAnimation {
                            useSentenceShowing = true
                            stage = 1
                        }
                    }
                }
                
                if stage == 1 {
                    Button("Show Synonyms") {
                        withAnimation {
                            synonymsShowing = true
                            stage = 2
                        }
                    }
                }
                
                if stage == 2 {

                }
                
                if stage == 3 {
                    Button ("Next Word") {
                        nextWord()
                    }
                }
                
            }
        }
        .preferredColorScheme(.dark)
        .padding()

    }
    
    func selectionMade(_ selection: String) {
        withAnimation {
            definitionShowing = true
            synonymsShowing = true
            useSentenceShowing = true
            stage = 3
        }
        
        selectionsEnabled = false
        
        if selection == word.answer {
            resultMessage = "CORRECT!"
        } else {
            resultMessage = "wrong..."
        }

    }
    
    func nextWord() {
        reset()
        recordScore()
    }
    
    func reset() {
        useSentenceShowing = false
        synonymsShowing = false
        definitionShowing = false
        stage = 0
        resultMessage = ""
        selectionsEnabled = true
    }
    
    func recordScore() {
        
    }
}

#Preview {
    ExamView(word: Word.example)
}

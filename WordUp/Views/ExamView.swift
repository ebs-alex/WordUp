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
    
//    @State private var partofSpeechOpacity = 0.0
//    @State private var partofSpeechShowing = false
    
    @State private var synonymsOpacity = 0.0
    @State private var synonymsShowing = false
    
    var body: some View {
        VStack {
            Text(word.name)
                .font(.largeTitle)
                .padding(.vertical)
            HStack {
                Text("\"\(word.phonetics)\"")
                    .font(.title3)
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
                        
                    } label: {
                        Text(option)
                            .font(.subheadline)
                            .foregroundStyle(.white)
                            .textAsButton()
                            .padding(.vertical)
                            .frame(width: 150)
                    }
                    
                }
            }
            
            
           
            .padding(.bottom,5)
            Text(word.fullDefinition)
                .bold()
                .font(.title3)
                .opacity(definitionShowing ? 1.0 : 0.0 )
                .padding(.horizontal)
            Spacer()
            Text(word.useSentence)
                .opacity(useSentenceShowing ? 1.0 : 0.0 )
            Spacer()
            
            LazyVGrid(columns: twoGrid, spacing: 5) {
                ForEach(word.synonyms, id: \.self) { syn in
                    Text(syn)
                }
            }
            .opacity(synonymsShowing ? 1.0 : 0.0)
            .font(.headline)
            Spacer()
            
            VStack(spacing: 25) {
                if stage == 0 {
                    Button("Use in Sentence") {
                        withAnimation {
                            useSentenceShowing.toggle()
                            stage = 1
                        }
                    }
                }
                
                if stage == 1 {
                    Button("Show Synonyms") {
                        withAnimation {
                            synonymsShowing.toggle()
                            stage = 2
                        }
                    }
                }
                
                if stage == 2 {
                    Button("Reveal Definition") {
                        withAnimation {
                            definitionShowing.toggle()
                            stage = 3
                        }
                    }
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
    
    func nextWord() {
        reset()
        recordScore()
    }
    
    func reset() {
        useSentenceShowing = false
        synonymsShowing = false
        definitionShowing = false
        stage = 0
    }
    
    func recordScore() {
        
    }
}

#Preview {
    ExamView(word: Word.example)
}

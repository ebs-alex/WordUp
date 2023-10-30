//
//  ExamView.swift
//  WordUp
//
//  Created by Alex Moran on 10/28/23.
//

import SwiftUI

struct ExamView: View {
    let word: Word
    
    @State private var definitionOpacity = 0.0
    @State private var definitionShowing = false
    
    @State private var useSentenceOpacity = 0.0
    @State private var useSentenceShowing = false
    
    @State private var partofSpeechOpacity = 0.0
    @State private var partofSpeechShowing = false
    
    @State private var synonymsOpacity = 0.0
    @State private var synonymsShowing = false
    
    var body: some View {
        VStack {
            Text(word.name)
                .font(.largeTitle)
                .padding(.vertical)
            HStack {
                Text("Level \(word.level)")
                    .font(.title2)
                    .padding(.horizontal)
                    .bold()
                Spacer()
            }
            Spacer()
            HStack {
                Text(word.partOfSpeech)
                    .font(.title2)
                    .padding(.horizontal)
                    .bold()
                    .opacity(partofSpeechShowing ? 1.0 : 0.0 )
                Spacer()
            }
            .padding(.vertical,5)
            HStack {
                Text("\"\(word.phonetics)\"")
                    .font(.title3)
                    .padding(.horizontal)
                Spacer()
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
            HStack {
                ForEach(word.synonyms, id: \.self) { syn in
                    Text(syn)
                }
                .frame(maxWidth: .infinity)
            }
            .opacity(synonymsShowing ? 1.0 : 0.0)
            .font(.headline)
            Spacer()
            
            VStack(spacing: 25) {
                Button(partofSpeechShowing ? "Hide Part of Speech" : "Show Part of Speech") {
                    withAnimation {
                        partofSpeechShowing.toggle()
                    }
                }

                Button(useSentenceShowing ? "Hide Use in Sentence" : "Use in Sentence") {
                    withAnimation {
                        useSentenceShowing.toggle()
                    }
                }
                
                Button(synonymsShowing ? "Hide Synonyms" : "Show Synonyms") {
                    withAnimation {
                        synonymsShowing.toggle()
                    }
                }
                
                Button(definitionShowing ? "Hide Definition" : "Reveal Definition") {
                    withAnimation {
                        definitionShowing.toggle()
                    }
                }
                
            }
        }
        .preferredColorScheme(.dark)
        .padding()

    }
}

#Preview {
    ExamView(word: Word.example)
}

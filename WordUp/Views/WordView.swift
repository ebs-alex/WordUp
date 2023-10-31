//
//  WordView.swift
//  WordUp
//
//  Created by Alex Moran on 10/25/23.
//

import SwiftUI

struct WordView: View {
    let word: Word
    
    private let twoGrid: [GridItem] = [
        .init(.flexible(), spacing: 2),
        .init(.flexible(), spacing: 2),
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                VStack {
                    HStack {
                        Text(word.phonetics)
                            .italic()
                            .font(.callout)
                        Spacer()
                    }
                    .padding(.bottom,5)
                    HStack {
                        Text("Level \(word.level)")
                        Spacer()
                    }
                    .bold()
                }
                .padding(.leading, 5)
                .padding(.bottom,30)
                
                Group {
                    HStack {
                        Text(word.partOfSpeech)
                        Spacer()
                    }
                    .font(.title)
                    .italic()
                    .padding(.leading, 10)
                    Text(word.fullDefinition)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 20)
                        .font(.title2)
                    Text("\"\(word.useSentence)\"")
                        .padding(.horizontal)
                        .padding(.vertical, 30)
                }
                Text("Synonyms:")
                    .font(.title2)
                
                
                LazyVGrid(columns: twoGrid, spacing: 5) {
                    ForEach(word.synonyms, id: \.self) { syn in
                        Text(syn)
                    }
                }
                Spacer()
            }
            .padding()
            .navigationTitle(Text(word.name))
            .navigationBarTitleDisplayMode(.large)
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    WordView(word: Word.example)
}

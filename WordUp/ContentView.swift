//
//  ContentView.swift
//  WordUp
//
//  Created by Alex Moran on 10/25/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    let words: [Word] = Bundle.main.decode("words.json")
    @State var randomWord = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                NavigationLink {
                    RandomWordView(word: words[randomWord])
                        .navigationTitle("Random Word")
                } label: {
                    Text("Give me random word")
                }
                Spacer()
                NavigationLink {
                    DictionaryView()
                } label: {
                    Text("Open Dictionary")
                }
                Spacer()
            }
            .navigationTitle("WordUp")
            .padding()
            .onAppear {
                randomWord = Int.random(in: 0...words.count-1)
            }
        }
    }
}

#Preview {
    ContentView()
}

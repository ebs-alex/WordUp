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
                Text("WordUp")
                    .font(.largeTitle)
                Spacer()
                NavigationLink {
                    RandomWordView(word: words[randomWord])
                        .navigationTitle("Random Word")
                } label: {
                    Text("Random Word")
                        .padding(15)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.blue, lineWidth: 5)
                        )
                }
                Spacer()
                NavigationLink {
                    DictionaryView()
                } label: {
                    Text("Open Dictionary")
                        .padding(15)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.blue, lineWidth: 5)
                        )
                }
                Spacer()
            }
//            .navigationTitle("WordUp")
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

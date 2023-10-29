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
                Text("Verbum Operandi")
                    .font(.largeTitle)
                    .padding(.top, 5)
                Spacer()
                NavigationLink {
                    ExamView(word: words[randomWord])
                } label: {
                    Text("Get to Work")
                        .padding(15)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.blue, lineWidth: 3)
                        )
                }
                Spacer()
                NavigationLink {
                    RandomWordView(word: words[randomWord])
                        .navigationTitle("Random Word")
                } label: {
                    Text("Random Word")
                        .padding(15)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.blue, lineWidth: 3)
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
                                .stroke(.blue, lineWidth: 3)
                        )
                }
                Spacer()
                NavigationLink {
                    SettingsView()
                } label: {
                    Text("Settings")
                        .padding(15)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.blue, lineWidth: 3)
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

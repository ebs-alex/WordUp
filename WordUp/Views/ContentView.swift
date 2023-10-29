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
            ZStack {
                Color.black
                    .ignoresSafeArea()
                VStack {
                    Text("Verbum")
//                        .font(.largeTitle)
                        .padding(.top, 5)
                        .font(.custom(
                                "AmericanTypewriter",
                                fixedSize: 36))
                    Spacer()
                    NavigationLink {
                        ExamView(word: words[randomWord])
                    } label: {
                        Text("Get to Work")
                            .textAsButton()
                            .font(.title2)
                    }
                    Spacer()
                    NavigationLink {
                        WordView(word: words[randomWord])
                            .navigationTitle("Random Word")
                    } label: {
                        Text("Random Word")
                            .textAsButton()
                    }
                    Spacer()
                    NavigationLink {
                        DictionaryView()
                    } label: {
                        Text("Open Dictionary")
                            .textAsButton()
                    }
                    Spacer()
                    NavigationLink {
                        SettingsView()
                    } label: {
                        Text("Settings")
                            .textAsButton()
                    }
                    Spacer()
                }
                .foregroundStyle(.white)
                .padding()
                .onAppear {
                    randomWord = Int.random(in: 0...words.count-1)
                }
            }
            
        }
    }
}

#Preview {
    ContentView()
}

//
//  ContentView.swift
//  WordUp
//
//  Created by Alex Moran on 10/25/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var em = ExamModel()
    @StateObject private var dm = DataModel()
    
    let words: [Word] = Bundle.main.decode("words.json")
    @State var randomWord = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                VStack {
                    Text("Brute Words")
                        .padding(.top, 5)
                        .underline()
                        .font(.custom(
                                "AmericanTypewriter",
                                fixedSize: 45))
                    Spacer()
                    NavigationLink {
                        ExamView()
                    } label: {
                        Text("Get to Work")
                            .font(.title)
                            .textAsButton()
                    }
//                    Spacer()
//                    NavigationLink {
//                        WordView(word: words[randomWord])
//                            .navigationTitle("Random Word")
//                    } label: {
//                        Text("Random Word")
//                            .textAsButton()
//                    }
                    Spacer()
                    NavigationLink {
                        DictionaryView()
                    } label: {
                        Text("Dictionary")
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
                    NavigationLink {
                        DataView()
                    } label: {
                        Text("Data")
                            .textAsButton()
                    }
                    Spacer()
                    HStack {
                        VStack {
                            Text("Words done today")
                                .font(.footnote)
                            Text("\(dm.wordCount)")
                                .font(.footnote)
                        }
                        Spacer()
                        VStack {
                            Text("Points Earned Today")
                                .font(.footnote)
                            Text("\(dm.totalPoints)")
                                .font(.footnote)
                        }
                    }
                    .padding(.horizontal)
                }
                .foregroundStyle(.white)
                .padding()
                .onAppear {
                    randomWord = Int.random(in: 0...words.count-1)
                }
            }
            
        }
        .environmentObject(em)
        .environmentObject(dm)
    }
}

#Preview {
    ContentView()
}

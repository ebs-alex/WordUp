//
//  Dictionary.swift
//  WordUp
//
//  Created by Alex Moran on 10/25/23.
//

import SwiftUI

struct DictionaryView: View {
    let words: [Word] = Bundle.main.decode("words.json")
    @State private var searchText = ""
    @State private var showingSortMenu = false
    
    enum sortStyles {
        case alphabetic, reverseAlphabetic
    }
    
    @State private var sortBy: sortStyles = .alphabetic
    
    var body: some View {
        NavigationStack {
            VStack {
                List(sortedResults) { word in
                    NavigationLink {
                        WordView(word: word)
                            .navigationTitle(word.name)
                    } label: {
                        Text(word.name)
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search Words")
            .preferredColorScheme(.dark)
            .navigationTitle("Dictionary")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingSortMenu = true
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .padding()
                            .font(.title2)
                    }
                }
            }
            .confirmationDialog("Sort Words ...", isPresented: $showingSortMenu, titleVisibility: .visible) {
                Button("Alphabetic") {
                    sortBy = .alphabetic
                }
                Button("Reverse Alphabetic") {
                    sortBy = .reverseAlphabetic
                }
            }

        }
    }
    
    var filteredResults: [Word] {
        if searchText.isEmpty {
            return words
        } else {
            return words.filter { $0.name.localizedCaseInsensitiveContains(searchText)}
        }
    }
    
    var sortedResults: [Word] {
        switch sortBy {
        case .alphabetic:
            return filteredResults.sorted()
        case .reverseAlphabetic:
            return filteredResults.sorted().reversed()
        }
        
    }
}

#Preview {
    DictionaryView()
}

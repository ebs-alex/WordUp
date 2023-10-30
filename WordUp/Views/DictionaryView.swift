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
    
    var body: some View {
        NavigationStack {
            VStack {
                List(filteredResults) { word in
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

        }
    }
    
    var filteredResults: [Word] {
        if searchText.isEmpty {
            return words
        } else {
            return words.filter { $0.name.localizedCaseInsensitiveContains(searchText)}
        }
    }
}

#Preview {
    DictionaryView()
}

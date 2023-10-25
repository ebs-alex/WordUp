//
//  Dictionary.swift
//  WordUp
//
//  Created by Alex Moran on 10/25/23.
//

import SwiftUI

struct DictionaryView: View {
    let words: [Word] = Bundle.main.decode("words.json")
    
    var body: some View {
        NavigationStack {
            VStack {
                List(words) { word in
                    NavigationLink {
                        Text(word.name)
                            .navigationTitle(word.name)
                    } label: {
                        Text(word.name)
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    DictionaryView()
}

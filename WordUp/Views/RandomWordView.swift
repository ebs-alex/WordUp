//
//  WordView.swift
//  WordUp
//
//  Created by Alex Moran on 10/25/23.
//

import SwiftUI

struct RandomWordView: View {
    let word: Word
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(word.fullDefinition)
            }
            .padding()
            .navigationTitle(Text(word.name))
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

//#Preview {
//    RandomWordView()
//}

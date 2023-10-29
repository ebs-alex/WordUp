//
//  WordView.swift
//  WordUp
//
//  Created by Alex Moran on 10/25/23.
//

import SwiftUI

struct WordView: View {
    let word: Word
    
    var body: some View {
        VStack {
            Text(word.name)
            Text(word.fullDefinition)
        }
    }
}

//#Preview {
//    WordView()
//}

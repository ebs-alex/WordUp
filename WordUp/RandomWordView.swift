//
//  WordView.swift
//  WordUp
//
//  Created by Alex Moran on 10/25/23.
//

import SwiftUI

struct RandomWordView: View {
    let word: Word
    @State private var defintionPresented = false
    @State private var definitionOpacity = 0.0
    
    var body: some View {
        VStack {
            Text(word.name)
            Text(word.fullDefinition)
                .opacity(definitionOpacity)
            Button("Show Definition") {
//                defintionPresented = true
                definitionOpacity = 1.0
            }
        }
        .sheet(isPresented: $defintionPresented) {
            VStack {
                Text(word.fullDefinition)
            }
            .padding()
        }
    }
}

//#Preview {
//    RandomWordView()
//}

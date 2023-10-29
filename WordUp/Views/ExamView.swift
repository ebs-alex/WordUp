//
//  ExamView.swift
//  WordUp
//
//  Created by Alex Moran on 10/28/23.
//

import SwiftUI

struct ExamView: View {
    let word: Word
    
    @State private var definitionOpacity = 0.0
    @State private var definitionShowing = false
    
    var body: some View {
        VStack {
            Spacer()
            Text(word.name)
                .font(.title)
            Spacer()
            Text(word.fullDefinition)
                .opacity(definitionShowing ? 1.0 : 0.0 )
            Spacer()
            Button(definitionShowing ? "Hide Definition" : "Reveal Definition") {
                withAnimation {
                    definitionShowing.toggle()
                }
            }
            Spacer()
        }
        .padding()

    }
}

//#Preview {
//    ExamView()
//}

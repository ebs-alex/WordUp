//
//  ViewModel.swift
//  WordUp
//
//  Created by Alex Moran on 10/25/23.
//

import Foundation
import SwiftUI

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        
        
        

 
        
        
//        func randomWord() {
//            
//        }
        

    }
    
}

struct BlueButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(15)
            .background(Color(red: 0, green: 0, blue: 0.5))
            .foregroundStyle(.white)
            .clipShape(Capsule())
    }
}

struct TitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .padding(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.blue, lineWidth: 2)
            )
    }
}

extension Text {
    func textAsButton() -> some View {
        self.bold().lineLimit(4)
            .modifier(TitleModifier())
    }
}

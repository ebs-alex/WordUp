//
//  SettingsView.swift
//  WordUp
//
//  Created by Alex Moran on 10/28/23.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    NavigationLink {
                        Text("Preffered Word Levels")
                    } label: {
                        Text("Preffered Word Levels")
                    }
                    .padding(10)
                    NavigationLink {
                        Text("Display")
                    } label: {
                        Text("Display")
                    }
                    .padding(10)
                    NavigationLink {
                        Text("Reset Data")
                    } label: {
                        Text("Reset Data")
                    }
                    .padding(10)
                    NavigationLink {
                        Text("Suggestions")
                    } label: {
                        Text("Send us a suggestion")
                    }
                    .padding(10)
                    NavigationLink {
                        Text("Credits")
                    } label: {
                        Text("Credits")
                    }
                    .padding(10)
                }
                .font(.title3)
                .padding(.vertical, 15)
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
            .preferredColorScheme(.dark)
                
        }
    }
}

#Preview {
    SettingsView()
}

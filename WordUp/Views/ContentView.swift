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
                            .bold()
                            .textAsButton()
                    }
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
                            Text("Words Presented")
                                .font(.footnote)
                            Text("\(dm.totalWordCount)")
                                .font(.footnote)
                        }
                        Spacer()
                        VStack {
                            Text("Weighted Success %")
                                .font(.footnote)
                            Text("\(dm.weightedSuccessRate, specifier: "%.1f")%")
                                .font(.footnote)
                        }
                    }
                    .padding(.horizontal)
                }
                .foregroundStyle(.white)
                .padding()
            }
            
        }
        .environmentObject(em)
        .environmentObject(dm)
        .onAppear {
//            print(dm.collectedData)
        }
    }
}

#Preview {
    ContentView()
}

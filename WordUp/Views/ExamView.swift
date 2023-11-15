//
//  ExamView.swift
//  WordUp
//
//  Created by Alex Moran on 10/28/23.
//

import SwiftUI

struct ExamView: View {
    @EnvironmentObject var vm: ViewModel;
    
    private let twoGrid: [GridItem] = [
        .init(.flexible(), spacing: 2),
        .init(.flexible(), spacing: 2),
    ]
    
    @State private var stage = 0
    
    @State private var definitionOpacity = 0.0
    @State private var definitionShowing = false
    
    @State private var useSentenceOpacity = 0.0
    @State private var useSentenceShowing = false
    
    @State private var synonymsOpacity = 0.0
    @State private var synonymsShowing = false
    
    @State private var resultMessage = ""
    @State private var selectionsEnabled = true
    
    @State private var showingEarnable = true
 
    
    
    var body: some View {
        VStack {
            HStack {
                Text(vm.currentExamWord.name)
                    .font(.custom(
                                "AmericanTypewriter",
                                size: 35,
                                relativeTo: .largeTitle))
                    .padding(3)
                    .bold()
                Spacer()
                VStack {
                    Text("Points won today")
                        .font(.footnote)
                    Text("0000")
                        .font(.headline)
                }
                .foregroundStyle(.green)
            }
            HStack {
                Spacer()
                Text("Level \(vm.currentExamWord.level)")
                    .font(.title2)
                    .padding(.horizontal)
                    .italic()
                    .bold()
                Spacer()
            }
            
            LazyVGrid(columns: twoGrid, spacing: 10) {
                ForEach(vm.options, id: \.self) { option in
                    Button {
                        selectionMade(option)
                    } label: {
                        Text(option)
                            .font(.subheadline)
                            .foregroundStyle(selectionsEnabled != false ? .white 
                                : option == vm.currentExamWord.answer ? .green
                                        : .red)
                            .optionStyle()
                    }
                }
                .allowsHitTesting(selectionsEnabled)
            }
            .padding(.bottom,5)
            
            HStack {
                if showingEarnable {
                    Text("Earnable Points:   \(vm.earnablePoints)")
                        .padding()
                        .font(.title3)
                        .bold()
                } else {
                    Text(resultMessage == "CORRECT!" ? "Points Won:   \(vm.earnablePoints)" : "Points Won:   -\(vm.earnablePoints)" )
                        .padding([.horizontal, .top])
                        .font(.title3)
                        .bold()
                        .foregroundStyle(resultMessage == "CORRECT!" ? .green : .red)
                }
                Spacer()
            }
            
            Text(resultMessage)
                .padding(.bottom,5)
                .font(.title)
                .foregroundStyle(resultMessage == "CORRECT!" ? .green : .red)
            
            ScrollView {
                VStack {
                    HStack {
                        Text("\"\(vm.currentExamWord.phonetics)\"")
                            .font(.headline)
                            .padding(.horizontal)
                        Spacer()
                    }
                    HStack {
                        Text(vm.currentExamWord.partOfSpeech)
                            .font(.title3)
                            .padding(.horizontal)
                            .bold()
                        Spacer()
                    }
                    VStack {
                        Text("\(vm.currentExamWord.fullDefinition)")
//                            .bold()
                            .font(.title2)
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                            .multilineTextAlignment(.center)
//                            .border(.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.white, lineWidth: 0.5)
                            )
                            .opacity(definitionShowing ? 1.0 : 0.0 )
                        Spacer()
                        Text("\"\(vm.currentExamWord.useSentence)\"")
                            .opacity(useSentenceShowing ? 1.0 : 0.0 )
                            .font(.headline)
                            .padding(.vertical)
                    }
                    
                    Spacer()
                    
                    Group {
                        Text("Synonyms")
                            .underline()
                        LazyVGrid(columns: twoGrid, spacing: 5) {
                            ForEach(vm.currentExamWord.synonyms, id: \.self) { syn in
                                Text(syn)
                            }
                        }
                    }
                    .opacity(synonymsShowing ? 1.0 : 0.0)
                    .font(.headline)
                    Spacer()
                }
//                .scrollIndicators(.visible)
            }
            VStack(spacing: 25) {
                if stage == 0 {
                    Button("Use in Sentence") {
                        withAnimation {
                            useSentenceShowing = true
                            vm.earnablePoints -= vm.currentExamWord.level
                            stage = 1
                        }
                    }
                }
                
                if stage == 1 {
                    Button("Show Synonyms") {
                        withAnimation {
                            synonymsShowing = true
                            vm.earnablePoints -= vm.currentExamWord.level
                            stage = 2
                        }
                    }
                }
                
                if stage == 2 {
                    //
                }
                
                
                if stage == 3 {
                    Button ("Next Word") {
                        vm.nextWord()
                        resetExamView()
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
        .padding()

    }
    
    func selectionMade(_ selection: String) {
        withAnimation {
            definitionShowing = true
            synonymsShowing = true
            useSentenceShowing = true
            showingEarnable = false
            stage = 3
        }
        
        selectionsEnabled = false
        
        if selection == vm.currentExamWord.answer {
            resultMessage = "CORRECT!"
        } else {
            resultMessage = "wrong..."
        }

    }
    
    
    func resetExamView() {
        useSentenceShowing = false
        synonymsShowing = false
        definitionShowing = false
        stage = 0
        resultMessage = ""
        selectionsEnabled = true
        showingEarnable = true
    }

}

#Preview {
    ExamView()
        .environmentObject(ViewModel())
}

//
//  ExamView.swift
//  WordUp
//
//  Created by Alex Moran on 10/28/23.
//

import SwiftUI

struct ExamView: View {
    @EnvironmentObject var em: ExamModel;
    @EnvironmentObject var gm: GameDataModel;
    
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
                Text(em.currentExamWord.name)
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
                    Text("\(gm.totalPoints)")
                        .font(.headline)
                }
                .foregroundStyle(.green)
            }
            HStack {
                Spacer()
                Text("Level \(em.currentExamWord.level)")
                    .font(.title2)
                    .padding(.horizontal)
                    .italic()
                    .bold()
                Spacer()
            }
            
            LazyVGrid(columns: twoGrid, spacing: 10) {
                ForEach(em.options, id: \.self) { option in
                    Button {
                        selectionMade(option)
                        recordScore(result: em.roundResult, word: em.currentExamWord, helpCount: em.helpCount, points: em.earnablePoints, gm: gm)
                    } label: {
                        Text(option)
                            .font(.subheadline)
                            .foregroundStyle(selectionsEnabled != false ? .white 
                                : option == em.currentExamWord.answer ? .green
                                        : .red)
                            .optionStyle()
                    }
                }
                .allowsHitTesting(selectionsEnabled)
            }
            .padding(.bottom,5)
            
            HStack {
                if showingEarnable {
                    Text("Earnable Points:   \(em.earnablePoints)")
                        .padding()
                        .font(.title3)
                        .bold()
                } else {
                    Text(em.roundResult == .won ? "Points Won:   \(em.earnablePoints)" : "Points Won:   \((em.currentExamWord.level * 3 + (em.helpCount * 3)) * -1) " )
                        .padding([.horizontal, .top])
                        .font(.title3)
                        .bold()
                        .foregroundStyle(em.roundResult == .won ? .green : .red)
                }
                Spacer()
            }
            
            Text(resultMessage)
                .padding(.bottom,5)
                .font(.title)
                .foregroundStyle(em.roundResult == .won ? .green : .red)
            
            ScrollView {
                VStack {
                    HStack {
                        Text("\"\(em.currentExamWord.phonetics)\"")
                            .font(.headline)
                            .padding(.horizontal)
                        Spacer()
                    }
                    HStack {
                        Text(em.currentExamWord.partOfSpeech)
                            .font(.title3)
                            .padding(.horizontal)
                            .bold()
                        Spacer()
                    }
                    VStack {
                        Text("\(em.currentExamWord.fullDefinition)")
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
                        Text("\"\(em.currentExamWord.useSentence)\"")
                            .opacity(useSentenceShowing ? 1.0 : 0.0 )
                            .font(.headline)
                            .padding(.vertical)
                    }
                    
                    Spacer()
                    
                    Group {
                        Text("Synonyms")
                            .underline()
                        LazyVGrid(columns: twoGrid, spacing: 5) {
                            ForEach(em.currentExamWord.synonyms, id: \.self) { syn in
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
                            em.earnablePoints -= em.currentExamWord.level
                            em.helpCount += 1
                            stage = 1
                        }
                    }
                }
                
                if stage == 1 {
                    Button("Show Synonyms") {
                        withAnimation {
                            synonymsShowing = true
                            em.earnablePoints -= em.currentExamWord.level
                            em.helpCount += 1
                            stage = 2
                        }
                    }
                }
                
                if stage == 2 {
                    //
                }
                
                
                if stage == 3 {
                    Button ("Next Word") {
                        em.nextWord(em.roundResult)
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
        
        if selection == em.currentExamWord.answer {
            resultMessage = "CORRECT!"
            em.roundResult = .won
        } else {
            resultMessage = "wrong..."
            em.roundResult = .lost
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

@MainActor func recordScore(result: ExamModel.roundResults, word: Word, helpCount: Int, points: Int, gm: GameDataModel) {
    if result == .won {
        let score = points
        gm.totalPoints += score
    } else {
        let score = (word.level * 3 + (helpCount * 3)) * -1
        gm.totalPoints += score
    }
}

#Preview {
    ExamView()
        .environmentObject(ExamModel())
        .environmentObject(GameDataModel())
}

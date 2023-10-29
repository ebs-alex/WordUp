//
//  Word.swift
//  WordUp
//
//  Created by Alex Moran on 10/25/23.
//

import Foundation

struct Word: Codable, Identifiable, Comparable {
    let id: String
    let name: String
    let answer: String
    let fullDefinition: String
    let partOfSpeech: String
    let useSentence: String
    let phonetics: String
    let level: Int
    let synonyms: [String]
    
    static func < (lhs: Word, rhs: Word) -> Bool {
        lhs.name < rhs.name
    }
        
    static let allWords: [Word] = Bundle.main.decode("words.json")
    static let example = allWords[0]

}

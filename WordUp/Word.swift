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
    let definition: String
    
    static func < (lhs: Word, rhs: Word) -> Bool {
        lhs.name < rhs.name
    }
    
}

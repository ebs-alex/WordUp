//
//  GameDataModel.swift
//  WordUp
//
//  Created by Alex Moran on 11/16/23.
//

import Foundation
import SwiftUI

@MainActor class DataModel: ObservableObject {
    
    @Published var totalPoints: Int = 0
    @Published var wordCount: Int = 0
    
}

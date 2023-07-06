//
//  Word.swift
//  Read and Learn
//
//  Created by Amal Ali on 06/07/2023.
//

import Foundation

public struct Word: Identifiable {
    public var id = UUID().uuidString
    var word: String
    var errorType: String
    var accuracyScore = 0.0
}

//
//  StringExtensions.swift
//  Read and Learn
//
//  Created by Amal Ali on 06/07/2023.
//

import Foundation

extension StringProtocol {
    var words: [SubSequence] {
        split(whereSeparator: \.isWhitespace)
    }
}

extension String {
    func toArray() -> [String] {
        let array = self.components(separatedBy: " ")
        return array
    }
    
    var withoutPunctuations: String {
        return self.components(separatedBy: CharacterSet.punctuationCharacters).joined(separator: "")
    }
}

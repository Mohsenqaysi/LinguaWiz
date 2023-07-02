//
//  Dictionary.swift
//  Read and Learn
//
//  Created by Amal Ali on 29/06/2023.
//

import Foundation

// MARK: - WelcomeElement
public struct DictionaryModel: Codable {
    let word: String
    let phonetic: String?
    let phonetics: [Phonetic]?
    let meanings: [Meaning]?
    let license: License?
//    let sourceUrls: [String]?
}

// MARK: - License
public struct License: Codable {
    let name: String
    let url: String
}

// MARK: - Meaning
public struct Meaning: Codable {
    let partOfSpeech: String
    let definitions: [Definition]
}

// MARK: - Definition
public struct Definition: Codable {
//    public var id = UUID().uuidString
    let definition: String
    let example: String?
}

// MARK: - Phonetic
public struct Phonetic: Codable {
    let text: String?
    let audio: String?
    let sourceURL: String?
    let license: License?
}

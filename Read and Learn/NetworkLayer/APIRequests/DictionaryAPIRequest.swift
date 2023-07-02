//
//  File.swift
//  
//
//  Created by Mohsen Qaysi on 19/04/2022.
//

import Foundation

public struct DictionaryAPIRequest: GetAPIRequest {
    public typealias ResponseType = [DictionaryModel]

    private var word: String
    
    public var endpoint: String {
        return "\(word)/"
    }

    public init(_ word: String) {
        self.word = word
    }
}

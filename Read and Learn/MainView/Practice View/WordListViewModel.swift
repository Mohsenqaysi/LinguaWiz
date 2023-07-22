//
//  WordListViewModel.swift
//  Read and Learn
//
//  Created by Amal Ali on 09/07/2023.
//

import Foundation

class WordListViewModel: ObservableObject {

    var reading: [String]
    var index: Int = 0 {
        didSet {
            print("index: \(index)")
        }
    }
    
    @Published var isSelected: Int?
    @Published var selectedWord = ""
    
    //MARK: OUTPUTS
    
    var didUpdateLevel: ((_ level: Level?) -> Void)?
    
    init(_ reading: [String]) {
        self.reading = reading
    }
}

extension WordListViewModel {
    var maxValue: Int { max(0, reading.count-1) }
    
    var minValue: Int { min(0, reading.count-1) }
    
    var nextButtonTitle: String {
        return index < maxValue ? nextTitle : lastOneTitle
    }
    
    var isLastpassage: Bool {
        return index < maxValue ? false : true
    }
    
    var isFirstpassage: Bool {
        return index > minValue ? false : true
    }
    
    var originalText: [String] {
        return reading[index].toArray()
    }
    
    var referenceText: String {
        return reading[index]
    }
}

// MARK: Titles
extension WordListViewModel {
    var checkTitle: String { "Check" }
    var nextTitle: String { "next" }
    var previousTitle: String { "previous" }
    var lastOneTitle: String { "Last One" }
    var lodingDataTitle: String { "Analysing Data ... Please Wait." }
    var showResultTitle: String { "Show Result" }
}

// MARK: Icons
extension WordListViewModel {
    var headerIcon: String { "headerIcon" }
    var buttonIcon: String { "buttonIcon" }
    var recordButtonIcon: String { "recordButtonIcon" }
}

//
//  DetailsViewModel.swift
//  Read and Learn
//
//  Created by Mohsen Qaysi on 6/1/23.
//

import Foundation

class DetailsViewModel: ObservableObject {
    var level: Level?
    var index: Int = 0 {
        didSet {
            print("index: \(index)")
//            if level != nil {
//                level?.readings.fromIndex = index
//                didUpdateLevel?(level)
//            }
//            UserDefaults.standard.set(level?.index, forKey: "curentLevel")
//            UserDefaults.standard.set(index, forKey: "curentLevelReadingIndex")
        }
    }

//    let appStorageUserlevel = UserDefaults.standard.string(forKey: "appStorageUserlevel")
    
    @Published var isSelected: Int?
    @Published var selectedWord = ""
    
    
    //MARK: OUTPUTS
    
    var didUpdateLevel: ((_ level: Level?) -> Void)?

    init() {}

    func increment() {
        if index < maxValue {
            index += 1
            updateLevel()
        }
    }

    func decrement() {
        if index >= minValue {
            index -= 1
            updateLevel()
        }
    }

    func updateLevel() {
        level?.readings.fromIndex = index
        didUpdateLevel?(level)
    }
}

extension DetailsViewModel {
    var maxValue: Int { max(0, readingsList.count-1) }
    
    var minValue: Int { min(0, readingsList.count-1) }

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
        return readingsList[index].toArray()
    }
    
    var referenceText: String {
        return readingsList[index]
    }

    var readingsList: [String] {
        return level?.readings.readings ?? []
    }
    
    var title: String {
        return level?.title ?? ""
    }
    
    var subTitle: String {
        return level?.subTitle ?? ""
    }
    
    var icon: String {
        return level?.icon ?? ""
    }
    
    var isUnlocked: Bool {
        return level?.unlocked ?? false
    }
}


// MARK: Titles
extension DetailsViewModel {
    var checkTitle: String { "Check" }
    var nextTitle: String { "next" }
    var previousTitle: String { "previous" }
    var lastOneTitle: String { "Last One" }
    var lodingDataTitle: String { "Analysing Data ... Please Wait." }
    var showResultTitle: String { "Show Result" }
}

// MARK: Icons
extension DetailsViewModel {
    var headerIcon: String { "headerIcon" }
    var buttonIcon: String { "buttonIcon" }
    var recordButtonIcon: String { "recordButtonIcon" }
}

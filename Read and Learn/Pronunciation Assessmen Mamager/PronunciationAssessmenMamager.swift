//
//  PronunciationAssessmenMamager.swift
//  Read and Learn
//
//  Created by Amal Ali on 06/07/2023.
//

import Foundation
import MicrosoftCognitiveServicesSpeech
import Differ

class PronunciationAssessmenMamager: ObservableObject {
    
    static let shared = PronunciationAssessmenMamager()
    @Published var loddedData: Bool = false
    @Published var wordsList: [Word] = []
    @Published var errorsList: [Word] = []
    @Published var pronunciationResult: String?

    var key: String
    var region: String
    
    private init(key: String = "1bbef2e22b60439d8ecdc6b25ebc9897", region: String = "eastus") {
        self.key = key
        self.region = region
    }
    
    var hasAssessmentResult: Bool {
        return !wordsList.isEmpty
    }

    func rest() {
        pronunciationResult = nil
        errorsList.removeAll()
        wordsList.removeAll()
    }
    
    func pronunciationAssessmentWithStream(_ path: URL, referenceText: String) {
        do {
            loddedData = true
            rest()
            print("referenceText: \(referenceText)")
            print("pronunciation assessment audio file path: ", path.absoluteString)
            
            
            let speechConfig = try SPXSpeechConfiguration(subscription: key, region: region)
            let audioDataWithHeader = try Data(contentsOf: path)
            
            let audioData = Array(audioDataWithHeader[46..<audioDataWithHeader.count])
            let startTime = Date()
            
            guard let audioFormat = SPXAudioStreamFormat(usingPCMWithSampleRate: 16000, bitsPerSample: 16, channels: 1),
                  let audioInputStream = SPXPushAudioInputStream(audioFormat: audioFormat) else {
                print("Error: Failed to create audio input stream.")
                loddedData = false
                return
            }
            
            guard let audioConfig = SPXAudioConfiguration(streamInput: audioInputStream) else {
                print("Error: audioConfig is Nil")
                loddedData = false
                return
            }
            
            let speechRecognizer = try SPXSpeechRecognizer(speechConfiguration: speechConfig, language: "en-US", audioConfiguration: audioConfig)
            
            let pronAssessmentConfig = try SPXPronunciationAssessmentConfiguration(referenceText, gradingSystem: SPXPronunciationAssessmentGradingSystem.hundredMark, granularity: SPXPronunciationAssessmentGranularity.word, enableMiscue: true)
            
            try pronAssessmentConfig.apply(to: speechRecognizer)
            
            audioInputStream.write(Data(audioData))
            audioInputStream.write(Data())
            
            // Handle the recognition result
            try speechRecognizer.recognizeOnceAsync { [weak self] result in
                guard let pronunciationResult = SPXPronunciationAssessmentResult(result) else {
                    print("Error: pronunciationResult is Nil")
                    self?.loddedData = false
                    return
                }
                var finalResult = ""
                let resultText = "Accuracy Score: \(pronunciationResult.accuracyScore)\nPronunciation Score: \(pronunciationResult.pronunciationScore)\nCompleteness Score: \(pronunciationResult.completenessScore)\nFluency Score: \(pronunciationResult.fluencyScore)"
                print(resultText)
                finalResult.append("\(resultText)\n")
                finalResult.append("\nword    accuracyScore   errorType\n")
                
                if let words = pronunciationResult.words {
                    for word in words {
                        
                        guard let wordString = word.word,
                              let errorType = word.errorType else { return }
                        let wordResult = Word(word: wordString, errorType: errorType, accuracyScore: word.accuracyScore)
                        DispatchQueue.main.async {
                            self?.pronunciationResult = resultText
                            if errorType != "Insertion" {
                                self?.wordsList.append(wordResult)
                            }
                            if word.accuracyScore <= 50 && errorType != "Insertion" {
                                self?.errorsList.append(wordResult)
                            }
                        }
                        finalResult.append("\(wordString)    \(word.accuracyScore)   \(errorType)\n")
                    }
                }
                
                print("finalResult: \(finalResult)")
                let endTime = Date()
                let timeCost = endTime.timeIntervalSince(startTime) * 1000
                print("Time cost: \(timeCost)ms")
                DispatchQueue.main.async {
                    self?.loddedData = false
                }
            }
            
        } catch let error {
            loddedData = false
            print(error.localizedDescription)
        }
    }
}

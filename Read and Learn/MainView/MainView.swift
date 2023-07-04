//
//  ContentView.swift
//  Read and Learn
//
//  Created by Mohsen Qaysi on 5/1/23.
//

import SwiftUI
import DesignSystem
import MicrosoftCognitiveServicesSpeech
import Differ

extension StringProtocol {
    var words: [SubSequence] {
        split(whereSeparator: \.isWhitespace)
    }
}

struct Word {
    var word: String
    var errorType: String
    var accuracyScore = 0.0
}

class PronunciationAssessmenMamager {
    
    static let shared = PronunciationAssessmenMamager()
    
    var sub: String
    var region: String
    
    private init(sub: String = "7c77d3804ac4405e8754ec15ad393e55", region: String = "eastus") {
        self.sub = sub
        self.region = region
    }
    
    func pronunciationAssessmentWithStream(_ path: URL, referenceText: String) {
        do {
            print("referenceText: \(referenceText)")
            print("pronunciation assessment audio file path: ", path.absoluteString)
            
//            let bundle = Bundle.main
//            let path = bundle.path(forResource: "whatstheweatherlike", ofType: "wav")
//            if (path == nil) {
//                print("Cannot find audio file!")
//                return
//            }
//            print("pronunciation assessment audio file path: ", path)
            
            
            let speechConfig = try SPXSpeechConfiguration(subscription: sub, region: region)
            let audioDataWithHeader = try Data(contentsOf: path)
//            let audioDataWithHeader = try Data(contentsOf: URL(fileURLWithPath: path!))
            
            let audioData = Array(audioDataWithHeader[46..<audioDataWithHeader.count])
            let startTime = Date()
            
            guard let audioFormat = SPXAudioStreamFormat(usingPCMWithSampleRate: 16000, bitsPerSample: 16, channels: 1),
                  let audioInputStream = SPXPushAudioInputStream(audioFormat: audioFormat) else {
                print("Error: Failed to create audio input stream.")
                return
            }
            
            guard let audioConfig = SPXAudioConfiguration(streamInput: audioInputStream) else {
                print("Error: audioConfig is Nil")
                return
            }
            
            let speechRecognizer = try SPXSpeechRecognizer(speechConfiguration: speechConfig, language: "en-US", audioConfiguration: audioConfig)
            
            let pronAssessmentConfig = try SPXPronunciationAssessmentConfiguration(referenceText, gradingSystem: SPXPronunciationAssessmentGradingSystem.hundredMark, granularity: SPXPronunciationAssessmentGranularity.word, enableMiscue: true)
            
            
            try pronAssessmentConfig.apply(to: speechRecognizer)
            
            audioInputStream.write(Data(audioData))
            audioInputStream.write(Data())
            
            // Handle the recognition result
            try speechRecognizer.recognizeOnceAsync { result in
                guard let pronunciationResult = SPXPronunciationAssessmentResult(result) else {
                    print("Error: pronunciationResult is Nil")
                    return
                }
                var finalResult = ""
                let resultText = "Accuracy score: \(pronunciationResult.accuracyScore), Pronunciation score: \(pronunciationResult.pronunciationScore), Completeness Score: \(pronunciationResult.completenessScore), Fluency score: \(pronunciationResult.fluencyScore)"
                print(resultText)
                finalResult.append("\(resultText)\n")
                finalResult.append("\nword    accuracyScore   errorType\n")
                
                if let words = pronunciationResult.words {
                    for word in words {
                        let wordString = word.word ?? ""
                        let errorType = word.errorType ?? ""
                        finalResult.append("\(wordString)    \(word.accuracyScore)   \(errorType)\n")
                    }
                }
                
                print("finalResult: \(finalResult)")
                let endTime = Date()
                let timeCost = endTime.timeIntervalSince(startTime) * 1000
                print("Time cost: \(timeCost)ms")
            }
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        if viewModel.isLoggedIn {
            TabView(selection: $viewModel.selectedTab) {
                ForEach(TabBarItem.allCases, id: \.id) { item in
                    TabItemView(for: viewModel.selectedTab)
                        .tabItem {
                            Image(item.icon)
                                .renderingMode(.template)
                                .background(viewModel.selectedTab == item ? Palette.backgroundSunset.color : Palette.basicWhite.color.opacity(0.5))
                            Text(item.title)
                                .foregroundColor(viewModel.selectedTab == item ? Palette.backgroundSunset.color : Palette.basicWhite.color.opacity(0.5))
                        }
                        .toolbarBackground(.visible, for: .tabBar)
                        .toolbarBackground(Palette.basicWhite.color, for: .tabBar)
                        .id(item)
                }
            }
            .accentColor(Palette.backgroundSunset.color)
        } else {
            //            LoginView(viewModel: viewModel.loginViewModel)
        }
    }

    @ViewBuilder
    func TabItemView(for tabItemView: TabBarItem) -> some View {
        switch tabItemView {
        case .home: HomeView(viewModel: viewModel.homeViewModel)
        case .wordList: RecodingView(audioRecorder: AudioRecorder())
        case .practice: Text(tabItemView.title)
        case .profile: Text(tabItemView.title)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 14", "iPad mini (6th generation)", "iPad Pro (12.9-inch) (6th generation)"], id: \.self) { deviceName in
            MainView()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}

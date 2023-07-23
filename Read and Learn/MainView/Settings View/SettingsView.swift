//
//  SettingsView.swift
//  Read and Learn
//
//  Created by Mohesn Qaysi on 7/22/23.
//

import SwiftUI

struct SettingsView: View {

    var sources: [String: String] = [
        "DesignSystem": "https://github.com/Mohsenqaysi/DesignSystem",
        "WrappingHStack":  "https://github.com/ksemianov/WrappingHStack",
        "AnimatedWaveform": "https://github.com/Wavemaster111188/AnimatedWaveform",
        "ActivityIndicatorView": "https://github.com/exyte/ActivityIndicatorView",
        "Dictionary API - Free": "https://dictionaryapi.dev",
        "Firebase": "https://github.com/firebase/firebase-ios-sdk",
        "Pronunciation Assessment API": "https://learn.microsoft.com/en-us/azure/ai-services/speech-service/pronunciation-assessment-tool?tabs=display",
        "Apple ACSpeech Synthesizer": "https://developer.apple.com/documentation/avfaudio/avspeechsynthesizer/",
    ]

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                List {
                    ForEach(sources.sorted(by: <), id: \.key) { key, value in
                        HStack(alignment: .center, spacing: 8) {
                            if let url = URL(string: value) {
                                Text(key)
                                    .font(.headline)
                                Link(destination: url) {
                                    Image(systemName: "link.circle.fill")
                                        .font(.title2)
                                }
                            }
                            Spacer()
                        }
                    }
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .navigationTitle("Credits")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

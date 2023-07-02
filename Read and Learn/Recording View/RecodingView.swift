//
//  RecodingView.swift
//  Voice Recorder
//
//  Created by Pinlun on 2019/10/30.
//  Copyright © 2019 Pinlun. All rights reserved.
//

import SwiftUI

struct RecodingView: View {
    
    @ObservedObject private var audioRecorder: AudioRecorder
    
    init(audioRecorder: AudioRecorder) {
        self.audioRecorder = audioRecorder
    }
    
    var body: some View {
        NavigationView {
            VStack {
                RecordingsList(audioRecorder: audioRecorder)
                Button {
                    audioRecorder.recording ? audioRecorder.stopRecording() : audioRecorder.startRecording()
                } label: {
                    Image(systemName: audioRecorder.recording ? "stop.fill" : "circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 70, height: 70)
                        .clipped()
                        .foregroundColor(.red)
                        .padding(.bottom, 40)
                }
                .animation(.spring(), value: audioRecorder.recording)
            }
            .navigationBarTitle("Voice Recorder")
            .navigationBarItems(trailing: EditButton())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RecodingView(audioRecorder: AudioRecorder())
    }
}

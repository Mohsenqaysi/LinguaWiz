//
//  DetailsView.swift
//  Read and Learn
//
//  Created by Mohsen Qaysi on 6/1/23.
//

import SwiftUI
import DesignSystem
import WrappingHStack
import AnimatedWaveform
import ActivityIndicatorView

struct DetailsView: View {
    @StateObject private var viewModel: DetailsViewModel
    @ObservedObject var audioRecorder: AudioRecorder
    @ObservedObject private var synthVM: SynthViewModel
    @ObservedObject private var audioPlayer = AudioPlayer()
    @ObservedObject private var pronunciationMamager = PronunciationAssessmenMamager.shared
    @State var displayDictionarySheet: Bool = false
    @State var showResutl: Bool = false
    
    init(viewModel: DetailsViewModel,
         level: Level,
         audioRecorder: AudioRecorder = AudioRecorder(),
         synthVM: SynthViewModel = SynthViewModel()
    ) {
        viewModel.level = level
        viewModel.index = level.readings.fromIndex
        self._viewModel = .init(wrappedValue: viewModel)
        self.audioRecorder = audioRecorder
        self.synthVM = synthVM
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            textPlaceHolderView
            Spacer()
            showResultButtonView
            Spacer()
                .safeAreaInset(edge: .bottom, alignment: .center, spacing: 0) {
                    VStack(alignment: .center, spacing: 20) {
                        HStack(alignment: .center, spacing: 5) {
                            previousButtonView
                            checkButtonView
                                .offset(y: -40)
                            nextButtonView
                        }
                    }
                    .background(.white)
                }
                .navigationBarTitle("\(viewModel.title) \(viewModel.subTitle)", displayMode: .inline)
        }
        .foregroundColor(pronunciationMamager.loddedData ? .gray : .white)
        .overlay(alignment: .top) {
            activityIndicatorView
        }
        .sheet(isPresented: $showResutl) {
            if let level = viewModel.level {
                ResultView(pronunciationMamager, showResutl: $showResutl, level: level)
            }
        }
        .sheet(isPresented: $displayDictionarySheet, onDismiss: {
            viewModel.isSelected = nil
        }) {
            DictionaryView(viewModel: DictionaryViewModel(viewModel.selectedWord))
                .presentationDetents([.medium, .large])
        }
        .onAppear {
            deleteCurrentAudio()
        }
        .onDisappear {
            synthVM.stop()
        }
    }
}

extension DetailsView {
    
    private var showResultButtonView: some View {
        Button(action: {
            showResutl.toggle()
        }, label: {
            Text(viewModel.showResultTitle)
                .foregroundColor(Palette.basicBlack.color)
                .font(Typography.headlineSemiBold.font)
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .fixedSize(horizontal: false, vertical: true)
                .background(Palette.backgroundSunset.color)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.horizontal, 24)
        })
        .disabled(!pronunciationMamager.hasAssessmentResult)
        .opacity(pronunciationMamager.hasAssessmentResult ? 1.0 : 0.0)
    }
    private var activityIndicatorView: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 8)
                .fill(.black.opacity(0.5))
                .frame(maxWidth: .infinity)
                .frame(height: 150.0)
            
            VStack(alignment: .center, spacing: 12) {
                Text(viewModel.lodingDataTitle)
                    .foregroundColor(Palette.basicWhite.color)
                    .font(Typography.bodySemiBold.font)
                ActivityIndicatorView(isVisible: $pronunciationMamager.loddedData, type: .equalizer(count: 5))
                    .frame(width: 50.0, height: 50.0)
                    .foregroundColor(Palette.backgroundSunset.color)
            }
        }
        .offset(y: 150)
        .opacity(pronunciationMamager.loddedData ? 1.0 : 0.0)
        .padding(.horizontal, 24)
    }
    
    private var textPlaceHolderView: some View {
        Image(viewModel.headerIcon)
            .resizable()
            .frame(height: 450)
            .overlay(alignment: .center) {
                VStack(spacing: 5) {
                    progressView
                    textContainerView
                }
            }
    }
    
    private var progressView: some View {
        ProgressView(value: Double(viewModel.index), total: Double(viewModel.maxValue))
            .progressViewStyle(LinearProgressViewStyle())
            .tint(Palette.backgroundGreen.color)
            .frame(height: 16)
            .scaleEffect(x: 1, y: 4, anchor: .center)
            .cornerRadius(8)
            .padding(.horizontal, 12)
    }
    
    private var textContainerView: some View {
        VStack(spacing: 0) {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white)
                .frame(height: 350)
                .padding(.horizontal, 12)
                .overlay(alignment: .center) {
                    textView
                    buttonsView
                }
        }
    }
    
    private var textView: some View {
        ScrollView {
            WrappingHStack(alignment: .leading, horizontalSpacing: 0, verticalSpacing: 0) {
                if !pronunciationMamager.hasAssessmentResult {
                    ForEach(Array(viewModel.originalText.enumerated()), id: \.offset) { id, word in
                        Text(word)
                            .id(id)
                            .onTapGesture {
                                print(word)
                                displayDictionarySheet.toggle()
                                viewModel.isSelected = id
                                viewModel.selectedWord = word
                            }
                            .animation(.easeInOut(duration: 0.2), value: viewModel.isSelected)
                            .foregroundColor(viewModel.isSelected == id ? .white : .black)
                            .padding(.horizontal, 3)
                            .padding(.vertical, 3)
                            .background(viewModel.isSelected == id ? Color.blue : .clear)
                            .cornerRadius(16)
                    }
                } else {
                    ForEach(Array(pronunciationMamager.wordsList.enumerated()), id: \.offset) { id, word in
                        Text(word.word)
                            .id(id)
                            .onTapGesture {
                                print(word)
                                displayDictionarySheet.toggle()
                                viewModel.isSelected = id
                                viewModel.selectedWord = word.word
                            }
                            .animation(.easeInOut(duration: 0.2), value: viewModel.isSelected)
                            .foregroundColor(word.accuracyScore <= 50 ? .red : .green)
                            .padding(.horizontal, 3)
                            .padding(.vertical, 3)
                            .background(viewModel.isSelected == id ? Color.blue : .clear)
                            .cornerRadius(16)
                    }
                }
            }
        }
        .padding(.horizontal, 12)
        .padding(.bottom, 80)
    }
    
    private var buttonsView: some View {
        Rectangle()
            .fill(Palette.backgroundOrangeLight.color)
            .frame(height: 73)
            .padding(.horizontal, 12)
            .overlay(alignment: .center) {
                HStack(alignment: .center, spacing: 0) {
                    Spacer()
                    playButtonView
                    Spacer()
                    recordButtonView
                    Spacer()
                }
            }
            .offset(y: 140)
    }
    
    private var playButtonView: some View {
        Button {
            if synthVM.isSpeaking {
                synthVM.stop()
            } else {
                synthVM.speak(text: viewModel.referenceText)
            }
        } label: {
            Image(systemName: synthVM.isSpeaking ? "speaker.wave.2.circle.fill" : "speaker.circle")
                .resizable()
                .frame(width: 48, height: 48)
                .symbolVariant(.circle.fill)
                .foregroundStyle(.green, .white)
                .clipShape(Circle())
                .animation(.spring(), value: synthVM.isSpeaking)
        }
        .disabled(audioRecorder.recording)
        .opacity(audioRecorder.recording ? 0.5 : 1.0)
    }
    
    @ViewBuilder
    private var recordButtonView: some View {
        HStack {
            if !audioRecorder.recordings.isEmpty {
                Button {
                    if let audioURL = audioRecorder.recordings.first?.fileURL {
                        if audioPlayer.isPlaying == false {
                            self.audioPlayer.startPlayback(audio: audioURL)
                        } else {
                            self.audioPlayer.stopPlayback()
                        }
                    }
                } label: {
                    Image(systemName: audioPlayer.isPlaying ? "pause.circle" : "play.circle")
                        .resizable()
                        .frame(width: 48, height: 48)
                        .symbolVariant(.circle.fill)
                        .foregroundStyle(.green, .white)
                        .clipShape(Circle())
                }
                
                Button {
                    deleteCurrentAudio()
                } label: {
                    Image(systemName: "trash.circle")
                        .resizable()
                        .frame(width: 48, height: 48)
                        .symbolVariant(.circle.fill)
                        .foregroundStyle(.red, .white)
                        .clipShape(Circle())
                }
            } else {
                Button {
                    audioRecorder.recording ? audioRecorder.stopRecording() : audioRecorder.startRecording()
                } label: {
                    if audioRecorder.recording {
                        AnimatedWaveformView(color: .green, renderingMode: .palette, secondaryColor: .white)
                            .frame(width: 48, height: 48)
                            .symbolVariant(.circle.fill)
                            .foregroundStyle(.green, .white)
                            .scaledToFit()
                            .clipShape(Circle())
                            .animation(.spring(), value: synthVM.isSpeaking)
                    } else {
                        Image(systemName: "mic.circle")
                            .resizable()
                            .frame(width: 48, height: 48)
                            .symbolVariant(.circle.fill)
                            .foregroundStyle(.green, .white)
                            .clipShape(Circle())
                    }
                }
                .disabled(synthVM.isSpeaking)
                .opacity(synthVM.isSpeaking ? 0.5 : 1.0)
            }
        }
        .animation(.linear(duration: 0.1), value: !audioRecorder.recordings.isEmpty)
    }
    
    private var checkButtonView: some View {
        Button {
            rest()
            if let audioURL = audioRecorder.recordings.first?.fileURL {
                pronunciationMamager.pronunciationAssessmentWithStream(audioURL, referenceText: viewModel.referenceText)
            }
            //            deleteCurrentAudio()
        } label: {
            Text(viewModel.checkTitle)
                .foregroundColor(Palette.basicBlack.color)
                .font(Typography.headlineSemiBold.font)
                .frame(height: 80)
                .frame(maxWidth: .infinity)
                .fixedSize(horizontal: false, vertical: true)
                .background(Palette.backgroundSunset.color)
                .clipShape(Circle())
                .padding(.horizontal, 24)
        }
        .disabled(audioRecorder.recordings.isEmpty || pronunciationMamager.hasAssessmentResult)
        .opacity(audioRecorder.recordings.isEmpty || pronunciationMamager.hasAssessmentResult ? 0.5 : 1.0)
        .animation(.easeOut(duration: 0.1), value: audioRecorder.recordings.isEmpty)
    }
    
    private func deleteCurrentAudio() {
        rest()
        if let audioURL = audioRecorder.recordings.first?.fileURL {
            audioRecorder.deleteRecording(urlsToDelete: [audioURL])
        }
    }
    
    private func rest() {
        pronunciationMamager.rest()
        viewModel.isSelected = nil
        synthVM.stop()
    }
    
    private var nextButtonView: some View {
        Button {
            deleteCurrentAudio()
//            print("maxValue: \(viewModel.maxValue)")
            if viewModel.index < viewModel.maxValue {
//                print("index: \(viewModel.index)")
                viewModel.index += 1
            }
        } label: {
            Text(viewModel.nextButtonTitle)
                .foregroundColor(Palette.basicBlack.color)
                .font(Typography.headlineSemiBold.font)
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .fixedSize(horizontal: false, vertical: true)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.horizontal, 24)
        }
        .disabled(viewModel.isLastpassage)
        .opacity(!viewModel.isLastpassage ? 1.0 : 0.4)
    }
    
    private var previousButtonView: some View {
        Button {
            deleteCurrentAudio()
            print("minValue: \(viewModel.minValue)")
            if viewModel.index >= viewModel.minValue {
//                print("index: \(viewModel.index)")
                viewModel.index -= 1
            }
        } label: {
            Text(viewModel.previousTitle)
                .foregroundColor(Palette.basicBlack.color)
                .font(Typography.headlineSemiBold.font)
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .fixedSize(horizontal: false, vertical: true)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.horizontal, 24)
        }
        .disabled(viewModel.isFirstpassage || pronunciationMamager.hasAssessmentResult)
        .opacity(viewModel.isFirstpassage || pronunciationMamager.hasAssessmentResult ? 0.4 : 1.0)
    }
}

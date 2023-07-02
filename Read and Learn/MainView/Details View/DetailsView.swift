//
//  DetailsView.swift
//  Read and Learn
//
//  Created by Mohsen Qaysi on 6/1/23.
//

import SwiftUI
import DesignSystem
import WrappingHStack

struct DetailsView: View {
    @ObservedObject private var viewModel: DetailsViewModel
    @ObservedObject var audioRecorder: AudioRecorder
    @ObservedObject private var synthVM: SynthViewModel
   
    @State var displayDictionarySheet: Bool = false

    let data = (1...10).map { "Item \($0)" }
    let columns = [
        GridItem(.adaptive(minimum: 50))
    ]
    
    init(viewModel: DetailsViewModel,
         audioRecorder: AudioRecorder = AudioRecorder(),
         synthVM: SynthViewModel = SynthViewModel()
    ) {
        self.viewModel = viewModel
        self.audioRecorder = audioRecorder
        self.synthVM = synthVM
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            textPlaceHolderView
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(data, id: \.self) { item in
                        Text(item)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 5)
                            .background(.red)
                            .cornerRadius(20)
                    }
                }
                .padding(.horizontal)
            }
            .safeAreaInset(edge: .bottom, alignment: .center, spacing: 0) {
                VStack(alignment: .center, spacing: 20) {
                    HStack(alignment: .center, spacing: 10) {
                        checkButtonView
                        nextButtonView
                    }
                }
                .padding()
                .background(.white)
            }
            .navigationBarTitle("\(viewModel.title) \(viewModel.subTitle)", displayMode: .inline)
        }
        .sheet(isPresented: $displayDictionarySheet) {
            DictionaryView(viewModel: DictionaryViewModel(viewModel.selectedWord))
        }
        .onDisappear {
            synthVM.stop()
        }
    }
}

extension DetailsView {
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
            WrappingHStack(alignment: .leading) {
                ForEach(Array(viewModel.readingsList[viewModel.index].toArray().enumerated()), id: \.offset) { id, word in
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
                        .padding(.horizontal, 10)
                        .padding(.vertical, 10)
                        .background(viewModel.isSelected == id ? Color.blue : .clear)
                        .cornerRadius(16)
                }
            }
        }
        .padding(.horizontal, 12)
        .padding(.bottom, 40)
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
                synthVM.speak(text: viewModel.readingsList[viewModel.index])
            }
        } label: {
            Image(systemName: synthVM.isSpeaking ? "pause.circle" : "play.circle")
                .resizable()
                .frame(width: 48, height: 48)
                .symbolVariant(.circle.fill)
                .foregroundStyle(.green, .white)
                .clipShape(Circle())
                .animation(.spring(), value: synthVM.isSpeaking)
        }
    }
    
    private var recordButtonView: some View {
        Button {
            audioRecorder.recording ? audioRecorder.stopRecording() : audioRecorder.startRecording()
        } label: {
            Image(systemName: "mic.circle")
                .resizable()
                .frame(width: 48, height: 48)
                .symbolVariant(.circle.fill)
                .foregroundStyle(.green, .white)
                .clipShape(Circle())
        }
        .disabled(synthVM.isSpeaking)
        .opacity(synthVM.isSpeaking ? 0.5 : 1.0)
    }
    
    private var checkButtonView: some View {
        Button {
        } label: {
            Text(viewModel.checkTitle)
                .foregroundColor(Palette.basicBlack.color)
                .font(Typography.headlineSemiBold.font)
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .fixedSize(horizontal: false, vertical: true)
                .background(Palette.backgroundSunset.color)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.horizontal, 24)
        }
    }
    
    private var nextButtonView: some View {
        Button {
            synthVM.stop()
            print("maxValue: \(viewModel.maxValue)")
            if viewModel.index < viewModel.maxValue {
                print("index: \(viewModel.index)")
                viewModel.index += 1
            }
        } label: {
            Text(viewModel.nextButtonTitle)
                .foregroundColor(Palette.basicBlack.color.opacity(0.4))
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
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(viewModel: DetailsViewModel(level: Level("", subTitle: "", icon: "", unlocked: true)))
    }
}

extension String {
    func toArray() -> [String] {
        let array = self.components(separatedBy: " ")
        return array
    }
}


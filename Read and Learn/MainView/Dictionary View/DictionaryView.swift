//
//  DictionaryView.swift
//  Read and Learn
//
//  Created by Amal Ali on 29/06/2023.
//

import SwiftUI
import AVFoundation

struct DictionaryView: View {
    @ObservedObject private var viewModel: DictionaryViewModel
    @StateObject private var soundManager = SoundManager()
    @ObservedObject private var synthVM: SynthViewModel = SynthViewModel()
    
    init(viewModel: DictionaryViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let dictionary = viewModel.dictionary {
                    Text("\(dictionary.word) | \(dictionary.phonetic ?? "") | \(dictionary.meanings?.first?.partOfSpeech ?? "")")
                        .foregroundColor(.black)
                        .bold()
                    if let meanings = dictionary.meanings {
                        ForEach(meanings, id: \.partOfSpeech) { meaning in
                            ForEach(Array(meaning.definitions.enumerated()), id: \.offset) { id, definition in
                                Text("\(id+1): \(definition.definition)")
                                    .foregroundColor(.black)
                                if let example = definition.example {
                                    Text("ex: \(example)")
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                }
            }
            .padding()
            .padding(.bottom, 40)
            .onAppear {
                viewModel.fetchDeifintion()
            }
        }
        
        .overlay(alignment: .bottom) {
            buttonsView
//            if let dictionary = viewModel.dictionary {
//
//                Button {
//                    if synthVM.isSpeaking {
//                        synthVM.stop()
//                    } else {
//                        synthVM.speak(text: dictionary.word)
//                    }
//                } label: {
//                    Image(systemName: synthVM.isSpeaking ? "pause.circle" : "play.circle")
//                        .resizable()
//                        .frame(width: 48, height: 48)
//                        .symbolVariant(.circle.fill)
//                        .foregroundStyle(.white, .black)
//                        .clipShape(Circle())
//                }
//            }
        }
    }
    
    private var buttonsView: some View {
        Rectangle()
            .fill(.white)
            .frame(height: 73)
//            .padding(.horizontal, 12)
            .overlay(alignment: .center) {
                if let dictionary = viewModel.dictionary {
                    Button {
                        if synthVM.isSpeaking {
                            synthVM.stop()
                        } else {
                            synthVM.speak(text: dictionary.word)
                        }
                    } label: {
                        Image(systemName: synthVM.isSpeaking ? "pause.circle" : "play.circle")
                            .resizable()
                            .frame(width: 48, height: 48)
                            .symbolVariant(.circle.fill)
                            .foregroundStyle(.white, .black)
                            .clipShape(Circle())
                    }
                }
            }
    }
    
    private var playButtonView: some View {
        Button {
            if synthVM.isSpeaking {
                synthVM.stop()
            } else {
                if let word = viewModel.dictionary?.word {
                    synthVM.speak(text: word)
                }
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
}

class SoundManager : ObservableObject {
    var audioPlayer: AVPlayer?
    
    func playSound(sound: String){
        if let url = URL(string: sound) {
            self.audioPlayer = AVPlayer(url: url)
        }
    }
}

struct SoundView: View {
    @State var isplaying = false
    @StateObject private var soundManager = SoundManager()
    
    private var url: String
    
    init(_ url: String) {
        self.url = url
    }
    
    var body: some View {
        Image(systemName: isplaying ? "pause.circle.fill": "play.circle.fill")
            .font(.system(size: 25))
            .padding(.trailing)
            .onTapGesture {
                soundManager.playSound(sound: url)
                isplaying.toggle()
                
                if isplaying {
                    soundManager.audioPlayer?.play()
                } else {
                    soundManager.audioPlayer?.pause()
                }
            }
    }
}

//struct DictionaryView_Previews: PreviewProvider {
//    static var previews: some View {
//        DictionaryView()
//    }
//}

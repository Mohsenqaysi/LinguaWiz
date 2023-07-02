import SwiftUI
import AVFoundation

class SynthViewModel: NSObject, ObservableObject {
    private var speechSynthesizer = AVSpeechSynthesizer()
    
    @Published var isSpeaking = false
    override init() {
        super.init()
        self.speechSynthesizer.delegate = self
    }
    
    func speak(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        speechSynthesizer.speak(utterance)
    }
    
    func stop() {
        speechSynthesizer.stopSpeaking(at: .immediate)
    }
}

extension SynthViewModel: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        print("started")
        isSpeaking = true
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        print("finished")
        isSpeaking = false
    }
}

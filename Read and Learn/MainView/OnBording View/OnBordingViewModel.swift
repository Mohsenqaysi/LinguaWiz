//
//  OnBordingViewModel.swift
//  Read and Learn
//
//  Created by Mohsen Qaysi on 7/10/23.
//

import Foundation


enum Levels: String, Codable, CaseIterable, Identifiable {
    var id: Self { self }
    case None, A, B, C
    
    var headerTitle: String {
        switch self {
        case .None: return "No Selection"
        case .A: return "Level One"
        case .B: return "Level Two"
        case .C: return "Level Three"
        }
    }
    
    var title: String {
        switch self {
        case .None: return "No Selection"
        case .A: return "A1 - A2"
        case .B: return "B1 - B2"
        case .C: return "C1 - C2"
        }
    }
}

class OnBordingViewModel: ObservableObject {
    
    var levels: [Levels] = [.A, .B, .C]
    
    // OUTPUT:
    var didTapGetStarted: (() -> Void)?
    
    func onTapGetStarted() {
        didTapGetStarted?()
    }
}

// titles
extension OnBordingViewModel {}

// icons
extension OnBordingViewModel {}

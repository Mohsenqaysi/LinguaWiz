//
//  MainViewModel.swift
//  Read and Learn
//
//  Created by Mohsen Qaysi on 5/1/23.
//

import Foundation

class MainViewModel: ObservableObject {

    @Published var selectedTab: TabBarItem
    
    init(selectedTab: TabBarItem = .home) {
        self.selectedTab = selectedTab
    }
}

//MARK: Models
extension MainViewModel {

    var onBordingViewModel: OnBordingViewModel {
        let viewModel = OnBordingViewModel()
        viewModel.didTapGetStarted = {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.selectedTab = .wordList
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.selectedTab = .home
                }
            }
        }
        return viewModel
    }
}

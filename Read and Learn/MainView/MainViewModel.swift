//
//  MainViewModel.swift
//  Read and Learn
//
//  Created by Mohsen Qaysi on 5/1/23.
//

import Foundation

class MainViewModel: ObservableObject {

    @Published var selectedTab: TabBarItem
    @Published var isLoggedIn: Bool = false
    
    init(selectedTab: TabBarItem = .home) {
        self.selectedTab = selectedTab
    }
}

//MARK: Models
extension MainViewModel {
    var homeViewModel: HomeViewModel {
        let viewModel = HomeViewModel()
        return viewModel
    }

    var onBordingViewModel: OnBordingViewModel {
        let viewModel = OnBordingViewModel()
        viewModel.didTapGetStarted = {
            self.isLoggedIn = true
            self.selectedTab = .home
        }
        return viewModel
    }
}

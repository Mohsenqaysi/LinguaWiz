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

    var isLoggedIn: Bool {
//        return authenticationStorage.storedAppAuthentication != nil
        return true
    }

//    private var userId: String {
//        var userId = ""
//        if let storedAppAuthentication = authenticationStorage.storedAppAuthentication {
//            userId = String(storedAppAuthentication.id)
//        }
//        return userId
//    }

}

//MARK: Models
extension MainViewModel {
    var homeViewModel: HomeViewModel {
        let viewModel = HomeViewModel()
//        viewModel.didTapProfile = { [weak self] in
//            self?.selectedTab = .settings
//        }
        return viewModel
    }

//    var loginViewModel: LoginViewModel {
//        let viewModel = LoginViewModel()
//        viewModel.didLogin = { [weak self] in
//            self?.selectedTab = .training
//        }
//        return viewModel
//    }
//
//    var settingsViewModel: SettingsViewModel {
//        let viewModel = SettingsViewModel()
//        viewModel.didLogout = { [weak self] in
//            self?.selectedTab = .training
//        }
//        return viewModel
//    }
}

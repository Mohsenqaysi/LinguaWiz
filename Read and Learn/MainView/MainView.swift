//
//  ContentView.swift
//  Read and Learn
//
//  Created by Mohsen Qaysi on 5/1/23.
//

import SwiftUI
import DesignSystem

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()

    var body: some View {
        if viewModel.isLoggedIn {
            TabView(selection: $viewModel.selectedTab) {
                ForEach(TabBarItem.allCases, id: \.id) { item in
                    TabItemView(for: viewModel.selectedTab)
                        .tabItem {
                            Image(item.icon)
                                .renderingMode(.template)
                                .background(viewModel.selectedTab == item ? Palette.backgroundSunset.color : Palette.basicWhite.color.opacity(0.5))
                            Text(item.title)
                                .foregroundColor(viewModel.selectedTab == item ? Palette.backgroundSunset.color : Palette.basicWhite.color.opacity(0.5))
                        }
                        .toolbarBackground(.visible, for: .tabBar)
                        .toolbarBackground(Palette.basicWhite.color, for: .tabBar)
                        .id(item)
                }
            }
            .accentColor(Palette.backgroundSunset.color)
        } else {
//            LoginView(viewModel: viewModel.loginViewModel)
        }
    }

    @ViewBuilder
    func TabItemView(for tabItemView: TabBarItem) -> some View {
        switch tabItemView {
        case .home: HomeView(viewModel: viewModel.homeViewModel)
        case .wordList: RecodingView(audioRecorder: AudioRecorder())
        case .practice: Text(tabItemView.title)
        case .profile: Text(tabItemView.title)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 14", "iPad mini (6th generation)", "iPad Pro (12.9-inch) (6th generation)"], id: \.self) { deviceName in
            MainView()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}

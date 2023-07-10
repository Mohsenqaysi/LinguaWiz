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
    let appStorageUserlevel = UserDefaults.standard.string(forKey: "appStorageUserlevel")

    var body: some View {
        if appStorageUserlevel != nil {
            TabView(selection: $viewModel.selectedTab) {
                ForEach(TabBarItem.allCases, id: \.id) { item in
                    TabItemView(for: viewModel.selectedTab)
                        .tabItem {
                            Label {
                                Text(item.title)
                                    .foregroundColor(viewModel.selectedTab == item ? Palette.backgroundSunset.color : Palette.basicWhite.color.opacity(0.5))
                            } icon: {
                                Image(item.icon)
                                    .renderingMode(.template)
                                    .background(viewModel.selectedTab == item ? Palette.backgroundSunset.color : Palette.basicWhite.color.opacity(0.5))
                            }
                            .id(item.id)
                        }
                        .toolbarBackground(.visible, for: .tabBar)
                        .toolbarBackground(Palette.basicWhite.color, for: .tabBar)
                }
            }
            .accentColor(Palette.backgroundSunset.color)
        } else {
            OnBordingView(viewModel.onBordingViewModel)
        }
    }

    @ViewBuilder
    func TabItemView(for tabItemView: TabBarItem) -> some View {
        switch tabItemView {
        case .home: HomeView(viewModel: viewModel.homeViewModel)
        case .wordList: WordListView()
        case .profile: Button {
            UserDefaults.standard.removeObject(forKey: "appStorageUserlevel")
        } label: {
            Text("Clear user data")
        }
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

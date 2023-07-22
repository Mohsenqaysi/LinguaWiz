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
    @AppStorage("savedErrorsList") var words: [String] = []
    @AppStorage("appStorageUserlevel") private var userlevel: Levels = .None

    var body: some View {
        if (userlevel != .None) {
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
        case .home: HomeView(viewModel: HomeViewModel(userlevel))
        case .wordList: WordListView(viewModel: WordListViewModel(words.shuffled()))
        case .vocablary: VocablaryView()
        }
    }
}

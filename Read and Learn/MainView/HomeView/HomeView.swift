//
//  HomeView.swift
//  Read and Learn
//
//  Created by Mohsen Qaysi on 5/1/23.
//

import SwiftUI
import DesignSystem

struct HomeView: View {
    @ObservedObject private var viewModel: HomeViewModel
    @State private var showNavigationBar = true
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                ForEach(viewModel.levels, id: \.title) { level in
                    NavigationLink {
                        VStack(alignment: .center) {
                            DetailsView(viewModel: DetailsViewModel(level: level))
                        }
                        .toolbar(.hidden, for: .tabBar)
                        .navigationBarTitle("\(level.title) \(level.subTitle)", displayMode: .inline)
                    } label: {
                        cellView(level)
                            .overlay(alignment: .topLeading) {
                                progressLevelView(level)
                            }
                    }
                    .disabled(!level.unlocked)
                }
            }
            .navigationTitle(viewModel.name)
        }
    }
}

extension HomeView {
    private func progressLevelView(_ level: Level) -> some View {
        VStack(alignment: .center, spacing: 1) {
            Image(level.unlocked ? viewModel.activeLevelIcon : viewModel.lockIcon)
                .renderingMode(level.unlocked ? .original : .template)
                .frame(width: 24, height: 24)
                .foregroundColor(.gray)
            Divider()
                .frame(width: 1.5)
                .frame(maxHeight: .infinity)
                .background(level.unlocked ? Palette.backgroundPurple.color : .gray)
        }
    }
    
    private func cellView(_ level: Level) -> some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 6) {
                    Spacer()
                    Text(level.title)
                        .foregroundColor(Palette.basicWhite.color)
                        .font(Typography.title2.font)
                    Text(level.subTitle)
                        .foregroundColor(Palette.basicWhite.color)
                        .font(Typography.headline.font)
                }
                .padding()
                Spacer()
            }
            .background {
                Image(level.icon)
                    .resizable()
                    .scaledToFill()
            }
        }
        .frame(height: 150)
        .frame(maxWidth: .infinity)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding(.horizontal, 24)
    }
}

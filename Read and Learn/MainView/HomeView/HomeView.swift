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

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                ForEach(viewModel.levels, id: \.title) { level in
                    NavigationLink {
                        VStack(alignment: .center) {
                            Image(viewModel.headerIcon)
                                .overlay(alignment: .center) {
                                    ZStack(alignment: .bottom) {
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color.white)
                                            .frame(width: 343, height: 276)
                                            .overlay(alignment: .center) {
                                                VStack {
                                                    Text("Some food stands have little plastic seats where you can sit and eat they cook the same dish over and over, like fried chicken on rice or Pad Thai noodles.")
                                                        .multilineTextAlignment(.center)
                                                    Spacer()
                                                }
                                                .padding(.top, 20)

                                            }

                                        Rectangle()
                                            .fill(Palette.backgroundOrangeLight.color)
                                            .frame(width: 343, height: 73)

                                            .overlay(alignment: .center) {
                                                Button {
                                                } label: {
                                                    Image(viewModel.buttonIcon)
                                                        .frame(width: 48, height: 43.35)
                                                        .clipShape(Circle())
                                                }
                                            }
                                    }
                                }
                            Spacer()
                        }
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
            }
        }
        .frame(width: 319, height: 150)
        .padding(.horizontal, 24)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}

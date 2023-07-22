//
//  OnBordingView.swift
//  Read and Learn
//
//  Created by Mohsen Qaysi on 7/10/23.
//

import SwiftUI
import DesignSystem

struct OnBordingView: View {
    @ObservedObject private var viewModel: OnBordingViewModel
    @AppStorage("appStorageUserlevel") private var userlevel: Levels = .None

    @State private var appStorageUserlevel: Levels = .A
    @State var presentAlert: Bool = false
    
    init(_ viewModel: OnBordingViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            onBordingBGView
                .overlay(alignment: .center) {
                    buttonsView
                }
        }
        .alert("Are you sure you want to select level \(appStorageUserlevel.title) you can not change it later?", isPresented: $presentAlert, actions: {
            Button("Yes, I am sure", role: .destructive, action: {
                userlevel = appStorageUserlevel
                print(userlevel.title.description)
                viewModel.onTapGetStarted()
            })
            Button("Cancel", role: .cancel, action: {})
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Palette.backgroundSunset.color.edgesIgnoringSafeArea(.all))
    }
}

extension OnBordingView {
    
    private var segmentedView: some View {
        Picker("", selection: $appStorageUserlevel) {
            ForEach(viewModel.levels, id: \.id) {
                Text($0.title)
                    .font(Typography.title.font)
                    .tag(0)
            }
        }
        .pickerStyle(.segmented)
    }
    
    private var onBordingBGView: some View {
        Image("onBording")
            .resizable()
            .frame(maxHeight: 581)
            .frame(maxWidth: .infinity)
            .edgesIgnoringSafeArea(.all)
    }
    
    private var buttonsView: some View {
        VStack(alignment: .center, spacing: 15) {
            Text("What is your level?")
                .foregroundColor(Palette.basicBlack.color)
                .font(Typography.title.font)
                .padding(.horizontal, 30)
            
            segmentedView
            Button {
                presentAlert.toggle()
            } label: {
                Text("Get Started")
                    .foregroundColor(Palette.basicBlack.color)
                    .font(Typography.title.font)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
            }
            .buttonStyle(.bordered)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 24)
        .background(Palette.backgroundSunset.color.edgesIgnoringSafeArea(.all))
    }
}

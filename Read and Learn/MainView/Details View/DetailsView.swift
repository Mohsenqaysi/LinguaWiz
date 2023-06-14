//
//  DetailsView.swift
//  Read and Learn
//
//  Created by Mohsen Qaysi on 6/1/23.
//

import SwiftUI
import DesignSystem

struct DetailsView: View {
    @ObservedObject private var viewModel: DetailsViewModel
    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .center) {
            ScrollView {
                textPlaceHolderView
                    .navigationBarTitle("\(viewModel.title) \(viewModel.subTitle)", displayMode: .inline)
            }
            recordButtonView
            checkButtonView
            nextButtonView
        }
    }
}

extension DetailsView {
    private var textPlaceHolderView: some View {
            
            Image(viewModel.headerIcon)
                .resizable()
                .frame(height: 450)
                .overlay(alignment: .center) {
                    VStack(spacing: 5) {
                        progressView
                        textContainerView
                    }
                }
    }
    
    private var progressView: some View {
        ProgressView(value: Double(viewModel.index), total: Double(viewModel.maxValue))
            .progressViewStyle(LinearProgressViewStyle())
            .tint(Palette.backgroundGreen.color)
            .frame(height: 16)
            .scaleEffect(x: 1, y: 4, anchor: .center)
            .cornerRadius(8)
            .padding(.horizontal, 12)
    }
    
    private var textContainerView: some View {
        VStack(spacing: 0) {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white)
                .frame(height: 350)
                .padding(.horizontal, 12)
                .overlay(alignment: .center) {
                    textView
                }
            playButtonView
        }
    }
    
    private var textView: some View {
        ScrollView {
            Text(viewModel.readingsList[viewModel.index])
                .foregroundColor(Palette.basicBlack.color)
                .font(Typography.title3.font)
                .multilineTextAlignment(.leading)
                .padding(12)
                .padding(.bottom, 60)
        }
        .padding(8)
    }
    
    private var playButtonView: some View {
        Rectangle()
            .fill(Palette.backgroundOrangeLight.color)
            .frame(height: 73)
            .padding(.horizontal, 12)
            .overlay(alignment: .center) {
                Button {
                    // play button action
                } label: {
                    Image(viewModel.buttonIcon)
                        .frame(width: 48, height: 43.35)
                        .clipShape(Circle())
                }
            }
            .offset(y: -50)
    }
    
    private var recordButtonView: some View {
        Button {
            // play button action
        } label: {
            Image(viewModel.recordButtonIcon)
                .resizable()
                .frame(width: 80.14, height: 76.14)
                .clipShape(Circle())
        }
    }
    
    private var checkButtonView: some View {
        Button {
        } label: {
            Text(viewModel.checkTitle)
                .foregroundColor(Palette.basicBlack.color)
                .font(Typography.headlineSemiBold.font)
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .fixedSize(horizontal: false, vertical: true)
                .background(Palette.backgroundSunset.color)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.horizontal, 24)
        }
    }
    
    private var nextButtonView: some View {
        Button {
            print("maxValue: \(viewModel.maxValue)")
            if viewModel.index < viewModel.maxValue {
                print("index: \(viewModel.index)")
                viewModel.index += 1
            }
        } label: {
            Text(viewModel.nextButtonTitle)
                .foregroundColor(Palette.basicBlack.color.opacity(0.4))
                .font(Typography.headlineSemiBold.font)
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .fixedSize(horizontal: false, vertical: true)
//                .background(Palette.backgroundSunsetLightest.color)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.horizontal, 24)
        }
        .disabled(viewModel.isLastpassage)
        .opacity(!viewModel.isLastpassage ? 1.0 : 0.4)
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(viewModel: DetailsViewModel(level: Level("", subTitle: "", icon: "", unlocked: true)))
    }
}

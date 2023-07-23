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
    @State var termsAndConditions: Bool = false
    @State var displayTermsAndConditions: Bool = false
    
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
        .sheet(isPresented: $displayTermsAndConditions) {
            termsView
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
    
    private var termsView: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Terms and Conditions")
                    .foregroundColor(Palette.basicBlack.color)
                    .font(Typography.title3SemiBold.font)
                Spacer()
                Button {
                    displayTermsAndConditions.toggle()
                } label: {
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .frame(width: 36, height: 36)
                        .symbolVariant(.circle.fill)
                        .foregroundStyle(.white, .black)
                        .clipShape(Circle())
                }
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 15)
            Divider()
                .frame(height: 1)
                .edgesIgnoringSafeArea(.horizontal)
            ScrollView {
                Text("""
***Terms and Conditions for ***LinguaWiz*** App:***

Welcome to ***LinguaWiz***! Before using our app, please carefully read and agree to the following Terms and Conditions:

***1. User Agreement:***

By using ***LinguaWiz***, you acknowledge that you have read, understood, and agreed to the terms and conditions laid out in this agreement.

***2. User Engagement Metrics:***

***LinguaWiz*** will collect user engagement metrics, including the duration of sessions spent on the app each day and the output of pronunciation errors made during the exercises. These metrics are used for the sole purpose of the Research project and enhancing your learning experience. No personal information or audio recordings will be stored or shared with third parties.

***3. Privacy Policy:***

We take your privacy seriously. Our Privacy Policy outlines how we collect, use, and protect your personal information. Please User Engagement Metrics to understand our data practices.

***4. App Usage:***

***LinguaWiz*** is designed to provide pronunciation and vocabulary support for English language learners. It is intended for use by individuals aged 18 and above.

***5. Feedback and Reviews:***

We value your feedback and reviews about the app. By providing feedback, you grant us the right to use, modify, and share your feedback for app improvement purposes.

***6. Contact Information:***

If you have any questions, concerns, or feedback about ***LinguaWiz***, please contact us at alhareta@tcd.ie.

By using ******LinguaWiz******, you agree to abide by these Terms and Conditions. If you do not agree with any of the terms, please refrain from using the app. Thank you for choosing ***LinguaWiz*** as your language learning companion and being part of our research journey. We hope you enjoy your learning journey with us!
""")
                .padding()
            }
        }
    }

    private var buttonsView: some View {
        VStack(alignment: .center, spacing: 15) {
            Text("What is your level?")
                .foregroundColor(Palette.basicBlack.color)
                .font(Typography.title.font)
                .padding(.horizontal, 30)
            
            segmentedView

            Toggle(isOn: $termsAndConditions) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("By clicking you agree to our")
                    Text("Terms and Conditions")
                        .foregroundColor(.blue)
                        .underline(true, color: .blue)
                }
                .onTapGesture {
                    displayTermsAndConditions.toggle()
                }
            }
            Button {
                presentAlert.toggle()
            } label: {
                Text("Get Started")
                    .foregroundColor(Palette.basicBlack.color)
                    .font(Typography.title.font)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
            }
            .disabled(!termsAndConditions)
            .opacity(!termsAndConditions ? 0.4 : 1.0)
            .buttonStyle(.bordered)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 24)
        .background(Palette.backgroundSunset.color.edgesIgnoringSafeArea(.all))
    }
}

struct OnBordingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBordingView(OnBordingViewModel())
    }
}

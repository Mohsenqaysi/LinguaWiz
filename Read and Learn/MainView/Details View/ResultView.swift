//
//  ResultView.swift
//  Read and Learn
//
//  Created by Mohsen Qaysi on 7/10/23.
//

import SwiftUI
import DesignSystem

struct ResultView: View {
    @AppStorage("savedErrorsList") var savedErrorsList: [String] = []
    @Binding private var showResutl: Bool

    private var pronunciationMamager = PronunciationAssessmenMamager.shared
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init(_ pronunciationMamager: PronunciationAssessmenMamager = PronunciationAssessmenMamager.shared,
         showResutl: Binding<Bool>
    ) {
        self.pronunciationMamager = pronunciationMamager
        self._showResutl = showResutl
    }
    
    var body: some View {
        ResultView
    }
}

extension ResultView {
    
    private var ResultView: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Result")
                    .foregroundColor(Palette.basicBlack.color)
                    .font(Typography.largeTitle.font)
                Spacer()
                Button {
                    showResutl.toggle()
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
            pronunciationResultView
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(pronunciationMamager.errorsList, id: \.id) { word in
                        Text(word.word)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(.red)
                            .cornerRadius(8)
                    }
                }
            }
            .onAppear {
                pronunciationMamager.errorsList.forEach {
                    if !savedErrorsList.contains($0.word) {
                        savedErrorsList.append($0.word)
                    }
                }
            }
        }
        .interactiveDismissDisabled()
        .presentationDetents([.medium, .large])
        .padding(.horizontal, 24)
    }
    
    @ViewBuilder
    private var pronunciationResultView: some View {
        if let pronunciationResult = pronunciationMamager.pronunciationResult {
            Text(pronunciationResult)
                .foregroundColor(Palette.basicBlack.color)
                .font(Typography.bodySemiBold.font)
        }
    }

}

//struct ResultView_Previews: PreviewProvider {
//    static var previews: some View {
//        ResultView()
//    }
//}

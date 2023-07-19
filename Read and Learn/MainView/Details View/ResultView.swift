//
//  ResultView.swift
//  Read and Learn
//
//  Created by Mohsen Qaysi on 7/10/23.
//

import SwiftUI
import DesignSystem
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import Firebase

struct ResultView: View {
    @AppStorage("savedErrorsList") var savedErrorsList: [String] = []
    @State private var errors: [String] = []
    @Binding private var showResutl: Bool
    private var level: Level
    @State private var userID: String? {
        didSet {
            createSession()
        }
    }

    private var pronunciationMamager = PronunciationAssessmenMamager.shared
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init(_ pronunciationMamager: PronunciationAssessmenMamager = PronunciationAssessmenMamager.shared,
         showResutl: Binding<Bool>,
         level: Level
    ) {
        self.pronunciationMamager = pronunciationMamager
        self._showResutl = showResutl
        self.level = level
    }
    
    var body: some View {
        ResultView
            .onAppear {
                fetchUserID()
            }
    }
    
    func fetchUserID() {
        Auth.auth().signInAnonymously { authResult, error in
            guard let user = authResult?.user else { return }
            print("fetchUserID uid: \(user.uid)")
            self.userID = user.uid
        }
    }
    
    private func createSession() {
        let db = Firestore.firestore()
        guard let userID = userID else { return }
        let docRef = db.collection("Pronunciation").document(userID)

        let data: [String : Any] = [
            Date().description : [
                level.title : level.subTitle,
                "Pronunciation Result for text \(level.readings.fromIndex+1)" : pronunciationMamager.pronunciationResult as Any,
                "Errors" : String().wordSet(errors),
            ] as [String : Any]
        ]
        
        docRef.setData(data, merge: true) { error in
            if let error = error {
                print("Error writing document: \(error)")
            } else {
                print("Document successfully written!")
            }
        }
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
                    errors.append($0.word)
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

//
//  PracticeView.swift
//  Read and Learn
//
//  Created by Amal Ali on 06/07/2023.
//

import SwiftUI
import DesignSystem

struct WordListView: View {
    @AppStorage("savedErrorsList") var items: [String] = []
    private var viewModel: WordListViewModel
    
    init(viewModel: WordListViewModel) {
        self.viewModel = viewModel
    }

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(viewModel.wordSet(items) , id: \.self) { word in
                        Button {
                        } label: {
                            Text(word)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .foregroundColor(.black)
                        }
                        .background(.white)
                        .buttonStyle(.bordered)
                        .buttonBorderShape(.roundedRectangle(radius: 8))
                    }
                }
            }
//            .onAppear {
//                viewModel.wordSet(items)
//            }
            .navigationTitle("Word List")
            .padding(.horizontal, 24)
        }
    }
}

//
//  DictionaryViewModel.swift
//  Read and Learn
//
//  Created by Amal Ali on 29/06/2023.
//

import Foundation
import Combine

class DictionaryViewModel: ObservableObject {
    
    private var word: String
    var anyCancellable = Set<AnyCancellable>()
    @Published var dictionary: DictionaryModel?
    var apiClient: CombineAPIClient
    
    init(_ word: String, apiClient: CombineAPIClient = KitCombineAPIClient()) {
        self.word = word
        self.apiClient = apiClient
    }
    
    func fetchDeifintion() {
        let reqquest = DictionaryAPIRequest(word)
        apiClient.execute(reqquest)
            .sink { completion in
                switch completion {
                case .finished: ()
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { [weak self] dictionary in
                print(dictionary)
                guard let dictionary = dictionary.first else { return }
                self?.dictionary = dictionary
            }
            .store(in: &anyCancellable)
    }
}

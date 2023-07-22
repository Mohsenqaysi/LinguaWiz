//
//  TabBarItem.swift
//  Read and Learn
//
//  Created by Mohsen Qaysi on 5/1/23.
//

import Foundation

enum TabBarItem: Int, CaseIterable, Identifiable {
    var id: Self { self }
    case home
    case wordList
    case vocablary
//    case profile

    var icon: String {
        switch self {
        case .home:
            return "homeIcon"
        case .wordList:
            return "startsIcon"
        case .vocablary:
            return "vocabularyIcon"
//        case .profile:
//            return "profileIcon"
        }
    }

    var title: String {
        switch self {
        case .home:
            return "Home"
        case .wordList:
            return "Words Practice"
        case .vocablary:
            return "Vocabulary Practice"
//        case .profile:
//            return "Profile"
        }
    }
}
